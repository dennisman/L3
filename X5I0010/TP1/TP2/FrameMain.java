import java.awt.Color;
import java.awt.Font;
import javax.swing.JFrame;
import javax.swing.JTextArea;

class MyFrame extends JFrame
{
  JTextArea txt = new JTextArea();

  public MyFrame(String s) 
  {
    setLayout(null);
 
    txt.setBounds(3, 3, 300, 200);
    add(txt);
 
    Font font = new Font("Verdana", Font.BOLD, 12);
    txt.setFont(font);
    txt.setForeground(Color.BLUE);
 
    txt.setText(s);
  }
}
 
public class FrameMain 
{
  private MyFrame myFrame_;

  public FrameMain(String s) 
  {
    myFrame_ = new MyFrame(s);
  }

  public void show()
  {
    myFrame_.show();
  }

  public void setSize(int x, int y)
  {
    myFrame_.setSize(x, y);
  }

  public void setTitle(String s)
  {
    myFrame_.setTitle(s);
  }
 
  public static void main(String [] args) 
  {
    FrameMain frame = new FrameMain("Tapez votre texte ici :\n");
    frame.setSize(313,233);
    frame.setTitle("Changement de police");
    frame.show();
   }
}