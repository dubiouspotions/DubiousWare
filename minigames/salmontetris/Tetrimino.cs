using Godot;
using System.Collections.Generic;

public class Tetrimino : KinematicBody2D
{
    private List<Block> blocks = new List<Block>();
    private const float speed = 300;
    
    [Signal]
    public delegate void done();
    
    public override void _Ready()
    {
        var frame = GD.Randi() % 3;
        foreach (var child in GetChildren())
        {
            if (child is Block block)
            {
                block.GetNode<AnimatedSprite>("Sprite").Frame = (int)frame;
                blocks.Add(block);
            }
        }
    }
    
    public override void _PhysicsProcess(float delta)
    {
        var velocity = new Vector2(0, speed);
        var collisionInfo = MoveAndCollide(velocity * delta);
        if (collisionInfo != null)
        {
            if (collisionInfo.Collider is Salmon dude)
            {
                dude.QueueFree();
                GetParent().GetParent().Call("setPlayerDidWin", false);
            } else
            {
                //GD.Print($"{Name} Collided with: {((Node) collisionInfo.Collider).Name}");
                foreach (var block in blocks)
                {
                    var oldPosition = block.GlobalPosition;
                    var oldRotation = block.GlobalRotation;
                    var oldScale = block.GlobalScale;
                    RemoveChild(block);
                    GetParent().AddChild(block);
                    block.GlobalPosition = oldPosition;
                    block.GlobalRotation = oldRotation;
                    block.GlobalScale = oldScale;
                    block.CollisionLayer = 1;
                }
                EmitSignal("done");
                GetParent().RemoveChild(this);
                QueueFree();
            }
        }
    }
}
