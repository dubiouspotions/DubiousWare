using Godot;

public class tetris : Node2D
{
    private int attempts = 10;
    private string[] prefabs ={"I_Tetrimino", "J_Tetrimino", "L_Tetrimino", "O_Tetrimino", "S_Tetrimino", "T_Tetrimino", "Z_Tetrimino"};
    
    public override void _Ready()
    {
        GD.Randomize();
        SpawnTetrimino();
    }

    private void SpawnTetrimino()
    {
        var prefab = prefabs[GD.Randi() % prefabs.Length];
        var scene = GD.Load<PackedScene>($"res://minigames/salmontetris/Tetriminos/{prefab}.tscn");
        var tetrimino = (Tetrimino)scene.Instance();
        tetrimino.GlobalPosition = new Vector2(16* (GD.Randi() % 13+2), 16+32);
        tetrimino.GlobalRotationDegrees = 90 * (GD.Randi() % 4);
        tetrimino.Connect("done", this, nameof(SpawnTetrimino));
        AddChild(tetrimino);
        var collisionInfo = tetrimino.MoveAndCollide(Vector2.Zero);
        if (collisionInfo != null)
        {
            //GD.Print($"{tetrimino.Name} Collided with: {((Node) collisionInfo.Collider).Name}");
            RemoveChild(tetrimino);
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
