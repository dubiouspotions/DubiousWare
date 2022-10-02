using Godot;
using System;

public class Block : StaticBody2D
{
    public CollisionShape2D shape;
    
    public override void _Ready()
    {
        foreach (var child in GetChildren())
        {
            if (child is CollisionShape2D shape)
            {
                this.shape = shape;
            }
        }
    }
}
