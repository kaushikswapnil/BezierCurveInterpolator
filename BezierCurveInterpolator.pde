BezierCurve bCurveInterpolator;

boolean draggingPoint = false;
int cpDragIndex = 0;

void setup()
{
  size(800, 800);
  
  bCurveInterpolator = new BezierCurve();
  bCurveInterpolator.AddControlPoint(10, 30);
  bCurveInterpolator.AddControlPoint(10, 90);
  bCurveInterpolator.AddControlPoint(80, 30);
  bCurveInterpolator.AddControlPoint(120, 150);
}

void draw()
{
  background(255);
  
  bCurveInterpolator.Display();
}

boolean IsNullWithEpsilon(float value)
{
  return abs(value - 0.0) <= EPSILON;
}

boolean IsGreaterWithEpsilon(float a, float b)
{
  return (a - b) > EPSILON;
}

boolean IsLesserWithEpsilon(float a, float b)
{
  return (a - b) < EPSILON;
}

boolean IsEqualWithEpsilon(float a, float b)
{
  return IsNullWithEpsilon(a-b); 
}

boolean IsGreaterOrEqualWithEpsilon(float a, float b)
{
   return IsGreaterWithEpsilon(a, b) || IsEqualWithEpsilon(a, b); 
}

boolean IsLesserOrEqualWithEpsilon(float a, float b)
{
   return IsLesserWithEpsilon(a, b) || IsEqualWithEpsilon(a, b); 
}

void mouseDragged()
{
  PVector mousePos = new PVector(mouseX, mouseY);
  ArrayList<ControlPoint> cPoints = bCurveInterpolator.m_ControlPoints; 
  
  if (draggingPoint == false)
  {
     for (int iter = 0; iter < cPoints.size(); ++iter)
     {
       if (IsLesserOrEqualWithEpsilon(PVector.dist(mousePos, cPoints.get(iter).GetPosition()), 8))
       {
         draggingPoint = true;
         cpDragIndex = iter;
       }
     }
  }
  else
  {
      cPoints.get(cpDragIndex).SetPosition(mousePos);
  }
}

void mouseReleased()
{
   if (draggingPoint == true)
   {
      draggingPoint = false; 
   }
}

void mouseClicked()
{
  if (mouseButton == LEFT)
  {
     bCurveInterpolator.AddControlPoint(mouseX, mouseY); 
  }
  else if (mouseButton == RIGHT)
  {
    PVector mousePos = new PVector(mouseX, mouseY);
    ArrayList<ControlPoint> cPoints = bCurveInterpolator.m_ControlPoints; 
  
    for (int iter = 0; iter < cPoints.size(); ++iter)
    {
      if (IsLesserOrEqualWithEpsilon(PVector.dist(mousePos, cPoints.get(iter).GetPosition()), 8))
      {
        cPoints.remove(iter);
        break;
      }
    }
  }
}
