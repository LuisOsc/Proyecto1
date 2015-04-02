require './Objeto'

class Esfera < Objeto

	attr_accessor :radio
	attr_accessor :centro

	def initialize(centro=Vector3.new,radio=0.0,color_difuso=Rgb_color_pixel.new,color_especular=Rgb_color_pixel.new,coef_especular=Vector3.new)
		@centro=centro
    @radio=radio
    super(color_difuso,color_especular,coef_especular)
	end

  def normal(p)
    pc = p.resta(@centro)
    return (Vector3.new(pc.a/@radio,pc.b/@radio,pc.c/@radio))
  end

	def intersectar(e,d)
    a =d.producto_escalar(d)
    b=2*(e.producto_escalar(d)-@centro.producto_escalar(d))
    c=@centro.producto_escalar(@centro)-2*(@centro.producto_escalar(e))-(@radio**2)+e.producto_escalar(e)
     
     discriminante=(b**2-(4*a*c))

    if(discriminante<0.0)
      return Float::INFINITY
    else
      t1=((b*-1)+Math.sqrt(discriminante))/2*a
      t2=((b*-1)-Math.sqrt(discriminante))/2*a
      if(discriminante>0.0)
        if(t1>0.0 && t2>0.0)
          if(t2>t1)
            return t1
          else
            return t2
          end
        else
          if (t1<0.0 && t2<0.0)
            return Float::INFINITY
          else
          if (t1>0.0)
            return t1
          else
            return t2
          end
          end
        end
      else
        return t1
      end
    end
end
end