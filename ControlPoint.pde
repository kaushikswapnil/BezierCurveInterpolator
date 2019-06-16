class ControlPoint
{
   PVector m_Position;
   
   ControlPoint(PVector pos)
   {
      m_Position = pos.get(); 
   }
   
   ControlPoint(float posX, float posY)
   {
      m_Position = new PVector(posX, posY);
   }
   
   void SetPosition(PVector pos)
   {
      m_Position = pos.get(); 
   }
   
   void SetPosition(float posX, float posY)
   {
      m_Position = new PVector(posX, posY);
   }
   
   PVector GetPosition()
   {
      return m_Position; 
   }
   
   void Display()
   {
      stroke(0);
      fill(175);
      ellipse(m_Position.x, m_Position.y, 16, 16);
   }
}
