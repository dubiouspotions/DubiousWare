using Godot;
using System.Collections.Generic;

public class Tetrimino : KinematicBody2D
{
    private List<Block> blocks = new List<Block>();
    
    [Signal]
    public delegate void done();
    
    public override void _Ready()
    {
        foreach (var child in GetChildren())
        {
            if (child is Block block)
            {
                blocks.Add(block);
            }
        }
    }
    
    public override void _PhysicsProcess(float delta)
    {
        var velocity = new Vector2(0, 600);
        var collisionInfo = MoveAndCollide(velocity * delta);
        if (collisionInfo != null)
        {
            if (collisionInfo.Collider is Salmon dude)
            {
                dude.QueueFree();
                GetParent().GetParent().Call("setPlayerDidWin", false);
            } else
            {
                foreach (var block in blocks)
                {
                    var oldPosition = block.GlobalPosition;
                    var oldRotation = block.GlobalRotation;
                    RemoveChild(block);
                    GetParent().AddChild(block);
                    block.GlobalPosition = oldPosition;
                    block.GlobalRotation = oldRotation;
                    block.CollisionLayer = 1;
                }
                EmitSignal("done");
                QueueFree();
            }
        }
    }
}
