class BezierCurve
{
  ArrayList<ControlPoint> m_ControlPoints; 
  
  BezierCurve()
  {
    m_ControlPoints = new ArrayList<ControlPoint>();
  }
  
  BezierCurve(ArrayList<ControlPoint> controlPoints)
  {
    m_ControlPoints = controlPoints; 
  }
    
  void AddControlPoint(ControlPoint cp)
  {
     m_ControlPoints.add(cp); 
  }
  
  void AddControlPoint(PVector pos)
  {
     m_ControlPoints.add(new ControlPoint(pos)); 
  }
  
  void AddControlPoint(float posX, float posY)
  {
     m_ControlPoints.add(new ControlPoint(posX, posY)); 
  }
  
  int GetOrderOfCurve()
  {
     return m_ControlPoints.size() - 1; 
  }
  
  void Display()
  {
     DrawDebug();
     DrawCurve();
  }
  
  void DrawDebug()
  {
     strokeWeight(1);
     PVector prevPos = new PVector(0, 0);
     for (int iter = 0; iter < m_ControlPoints.size(); ++iter)
     {
       PVector curPos = m_ControlPoints.get(iter).GetPosition();
       
       if (iter > 0)
       {
         stroke(255, 0, 0, 80);
         line(prevPos.x, prevPos.y, curPos.x, curPos.y); 
       } 
       
       m_ControlPoints.get(iter).Display();
       prevPos = curPos;
     }
  }
  
  void DrawCurve()
  {
    int curveOrder = GetOrderOfCurve();
    
    ArrayList<PVector> curvePoints = new ArrayList<PVector>();
    
    for (float t = 0; IsLesserOrEqualWithEpsilon(t, 1.0f); t += 0.001f)
    {
       float pX = 0;
       float pY = 0;
       
       float tInverse = 1-t;
       
       for (int cpIter = 0; cpIter < m_ControlPoints.size(); ++cpIter)
       {
          float comb = Combination(curveOrder, cpIter);
          comb += comb; //<>//
          comb -= comb;
          float pointCoeff = (float)(Combination(curveOrder, cpIter) * (Math.pow(tInverse, curveOrder - cpIter)) * (Math.pow(t, cpIter)));
          pX += pointCoeff * m_ControlPoints.get(cpIter).m_Position.x;
          pY += pointCoeff * m_ControlPoints.get(cpIter).m_Position.y;
       }
       
       curvePoints.add(new PVector(pX, pY));
       
       stroke(0, 255, 0, 255);
       point(pX, pY);
    }
  }
  
  int Combination(int n, int i) //nCi
  {
    return Factorial(n)/(Factorial(i) * Factorial(n-i));
  }
  
  int Factorial(int n)
  {
     int answer = 1;
     for (int i = 1; i <= n; ++i)
     {
        answer *= i; 
     }
     
     return answer; //<>//
  }
}
