using Godot;
using System;
using System.Drawing.Printing;

public partial class PrintHandler : Node
{
	public float hundred = 100;
	public string dir = "";
	public override void _Ready()
	{
		Console.WriteLine("The PrintHandler was instanced!");
	}
	
	public void MadeToPrint()
	{
		Console.WriteLine("Made it to MadeToPrint");
		PrintDocument pd = new PrintDocument();
		PaperSize paperSize = new PaperSize("MyCustomSize", 100, 100 );
		pd.PrintPage += PrintPage;
//		PrintPreviewDialog ppvw = new PrintPreviewDialog();
//		ppvw .Document = pd;
//		ppvw.ShowDialog();
		pd.Print();       
	}
	
	private void PrintPage(object o, PrintPageEventArgs e)
	{
		Console.WriteLine("We made it to private PrintPage!");
		System.Drawing.Image img = System.Drawing.Image.FromFile(dir);
//		Point loc = new Point(100, 100);
		
		e.Graphics.DrawImage(img, hundred, hundred );
//		e.Graphics.DrawImage(img, loc);
	}
	
	public void c_init(string text)
	{
		Console.WriteLine("c_init was passed to!");
		dir = text;
	}
}
