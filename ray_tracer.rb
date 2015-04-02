require_relative 'renderer'
require_relative 'Camara'
require_relative 'Esfera'
require_relative 'Triangulo'
require_relative 'Luz'

class RayTracer < Renderer

  attr_accessor :camara
  attr_accessor :listaobjetos

  def initialize(width, height)
    super(width, height, 255.0, 255.0, 255.0)
    e= Vector3.new(278.0,273.0,-800.0)
    up= Vector3.new(0.0,1.0,0.0)
    pv= Vector3.new(278.0,273.0,-700.0)
    alfa=39.31
    d=0.035
    @camara= Camara.new(e,up,pv,alfa,d)
    c1=Rgb_color_pixel.new(0.156,0.126,0.506)
    c2=Rgb_color_pixel.new(1.0,1.0,1.0)
    v1=Vector3.new(370.0,120.0,370.0)
    e1=Esfera.new(v1,120.0,c1,c2,100.0)

    c11=Rgb_color_pixel.new(0.656,0.626,0.107)
    c22=Rgb_color_pixel.new(1.0,1.0,1.0)    
    v11=Vector3.new(130.0,100.0,130.0)
    e2=Esfera.new(v11,100.0,c11,c22,100.0)

    tv1=Vector3.new(552.0,8.0,0.0)
    tv2=Vector3.new(0.0,0.0,0.0)
    tv3=Vector3.new(0.0,0.0,559.2)
    ct1=Rgb_color_pixel.new(0.0,0.4,0.0)
    c2t1=Rgb_color_pixel.new(0.0,0.0,0.0)
    t1=Triangulo.new(tv1,tv2,tv3,ct1,c2t1,1.0)

    t2v1=Vector3.new(552.0,8.0,0.0)
    t2v2=Vector3.new(549.6,0.0,552.8)
    t2v3=Vector3.new(0.0,0.0,559.2)
    ct2=Rgb_color_pixel.new(0.0,0.4,0.0)
    c2t2=Rgb_color_pixel.new(0.0,0.0,0.0)
    t2=Triangulo.new(t2v1,t2v2,t2v3,ct2,c2t2,1.0)
    @listaobjetos=[]
    @listaobjetos << e1 << e2 << t1 << t2

    @color_ambiente = Rgb_color_pixel.new(0.2,0.2,0.2)

    color_luz=Rgb_color_pixel.new(0.8,0.7,0.6)
    posicion=Vector3.new(278.0,547.0,279.5)
    @luz1=Luz.new(color_luz,posicion)
    @lista_luces = []
    @lista_luces << @luz1


  end

def max(n1,n2)
    if n1>n2
      return n1
    else
      return n2
    end
end

  def calcular_shading(obj,e,d,t)
    dt = d.produc_valor_vector(t)

    dt.a = dt.a/dt.modulo()
    dt.b = dt.b/dt.modulo()
    dt.c = dt.c/dt.modulo()

    pt = e.suma(dt)

    pt.a = pt.a/pt.modulo()
    pt.b = pt.b/pt.modulo()
    pt.c = pt.c/pt.modulo()

    if obj.class == Triangulo
      n = obj.normal()
    end
    if obj.class == Esfera
      n = obj.normal(pt)
    end
    
     n.a= n.a/n.modulo()
     n.b= n.b/n.modulo()
     n.c= n.c/n.modulo()


    v = e.resta(pt)    #ia color ambiente

     v.a= v.a/v.modulo()
     v.b= v.b/v.modulo()
     v.c= v.c/v.modulo()

    #@lista_luces.each do |luz|

      kd = obj.color_difuso
      ks = obj.color_especular
      p =  obj.coef_especular
      ia= @color_ambiente # Ia es color de ambiente para la primera suma
      i = @luz1.color
      l = @luz1.posicion.resta(pt)
      
      vmasl = v.suma(l)
      d1 = vmasl.a/vmasl.modulo()
      d2 = vmasl.b/vmasl.modulo()
      d3 = vmasl.c/vmasl.modulo()

      h=Vector3.new(d1,d2,d3)

      nl = n.producto_escalar(l)
      nh = n.producto_escalar(h)
      valorMax2 = (max(0,nh))**p # elevado a coef_especular
      valorMax = max(0,nl)

    parte1 = kd.producto(ia.a,ia.b,ia.c).producto_n_RGB(valorMax)
    parte2 = ks.producto(i.a,i.b,i.c).producto_n_RGB(valorMax2)
    parte3 = kd.producto(ia.a,ia.b,ia.c) # esta es la primera suma
    #end
  #  return #parte1.suma(parte2.a,parte2.b,parte2.c) 
   # return ((parte1.suma(parte2.a,parte2.b,parte2.c)).suma(parte3.a,parte3.b,parte3.c))
   return parte1
  end

  def calculate_pixel(i,j)
  d=@camara.calcular_d(i,j,@width,@height)
  e=@camara.e
  tmin = Float::INFINITY
  oint = nil

   @listaobjetos.each do |obj|
    t=obj.intersectar(e,d)
    
    if t < tmin
    	tmin=t
    	oint=obj
    end
   end

 if oint==nil
 color=Rgb_color_pixel.new(0.0,0.0,0.0)
 else
   color=calcular_shading(oint,e,d,tmin)
 end

  return {red: color.a, green: color.b, blue: color.c}
  end

end