using Godot;

public class Salmon : KinematicBody2D
{
    const int walkSpeed = 600;
    const float gravity = 800;
    const float jumpSpeed = 800;
    const ulong jumpTime = 300;
    const ulong jumpCancelTime = 175;

    private Vector2 velocity;
    private AnimatedSprite sprite;
    private ulong lastJump = 0;

    private string Left => GetParent().GetParent().Get("player_index") + "_left";
    private string Right => GetParent().GetParent().Get("player_index") + "_right";
    private string Jump => GetParent().GetParent().Get("player_index") + "_action";

    public override void _Ready()
    {
        sprite = (AnimatedSprite) GetNode("AnimatedSprite");
    }

    public override void _PhysicsProcess(float delta)
    {
        if (Input.IsActionJustPressed(Jump) && IsOnFloor())
        {
            lastJump = Time.GetTicksMsec();
        }
        
        var snap = 60 * Vector2.Down;
        
        if (Input.IsActionPressed(Jump) && Time.GetTicksMsec() < lastJump + jumpTime)
        {
            velocity.y = -jumpSpeed;
            snap = Vector2.Zero;
        }
        else if (Time.GetTicksMsec() < lastJump + jumpCancelTime)
        {
            velocity.y = -jumpSpeed;
            snap = Vector2.Zero;
        } else if (IsOnFloor())
        {
            velocity.y = 0;
        }
        else
        {
            velocity.y = gravity;
        }

        if (Input.IsActionPressed(Left))
        {
            velocity.x = -walkSpeed;
            sprite.Scale = new Vector2(1, 1);
        } else if (Input.IsActionPressed(Right))
        {
            velocity.x = walkSpeed;
            sprite.Scale = new Vector2(-1, 1);
        } else
        {
            velocity.x = 0;
        }
        
        if (velocity.x != 0)
        {
            sprite.Rotation = Time.GetTicksMsec() % 200 < 100 ? -0.25f : 0.25f;
        }
        else
        {
            sprite.Rotation = 0;
        }

        MoveAndSlideWithSnap(velocity, snap, new Vector2(0, -1), true);
    }
}
