using Godot;

public class tetris : Node2D
{
    //private Tetrimino currentTetrimino;
    private int attempts = 10;
    
    public override void _Ready()
    {
        //GD.Randomize();
        SpawnTetrimino();
    }

    private void SpawnTetrimino()
    {
        var scene = GD.Load<PackedScene>("res://minigames/salmontetris/L_Tetrimino.tscn");
        var tetrimino = (Tetrimino)scene.Instance();
        tetrimino.GlobalPosition = new Vector2(16* (GD.Randi() % 13+2), 16+32);
        tetrimino.GlobalRotationDegrees = 90 * (GD.Randi() % 4);
        tetrimino.Connect("done", this, nameof(SpawnTetrimino));
        AddChild(tetrimino);
        var collisionInfo = tetrimino.MoveAndCollide(Vector2.Zero);
        if (collisionInfo != null)
        {
            tetrimino.QueueFree();
            attempts--;
            if (attempts > 0)
            {
                SpawnTetrimino();
            }
        } else 
        {
            attempts = 10;
        }
    }

}
