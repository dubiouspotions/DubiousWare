using Godot;

public class Countdown : RichTextLabel
{
    private Timer timer;
    private int seconds = 10;
    
    [Signal]
    public delegate void countdown_done();
    
    public override void _Ready()
    {
        timer = new Timer();
        timer.Connect("timeout", this, "OnSecond");
        timer.WaitTime = 1;
        AddChild(timer);
        timer.Start();

        UpdateText();
    }

    private void OnSecond()
    {
        seconds--;

        if (seconds < 0)
        {
            EmitSignal("countdown_done");
            QueueFree();
        }

        UpdateText();
    }

    private void UpdateText()
    {
        BbcodeText = "[center]" + (seconds > 0 ? $"{seconds}" : "GO!") + "[/center]";
    }
}
