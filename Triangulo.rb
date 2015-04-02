require "./Objeto"
require "./Matriz"

class Triangulo < Objeto
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z

    def initialize(x=Vector3.new,y=Vector3.new,z=Vector3.new,color_difuso=Rgb_color_pixel.new,color_especular=Rgb_color_pixel.new,coef_especular=0.0)
    	@x=x
    	@y=y
    	@z=z
        super(color_difuso,color_especular,coef_especular)
    end
    
    def determinante(vec1,vec2,vec3)
    sumIz = ((vec1.a*vec2.b*vec3.c)+(vec1.b*vec2.c*vec3.a)+(vec1.c*vec2.a*vec3.b))
    sumDer = ((vec1.b*vec2.a*vec3.c)+(vec1.a*vec2.c*vec3.b)+(vec1.c*vec2.b*vec3.a))
    return (sumIz-sumDer)
    end

    def normal()
        ba =@y.resta(@x)
        ca =@z.resta(@x)
        resp = ba.producto_vectorial(ca)
        mod= resp.modulo()
        if resp.a < 0 && resp.b < 0 && resp.c < 0
           return (Vector3.new(resp.a/mod*-1,resp.b/mod*-1,resp.c/mod*-1))
        else
           return (Vector3.new(resp.a/mod,resp.b/mod,resp.c/mod))
        end
    end
    
    def intersectar(e,d)
        m=Matriz.new(@y.a-@x.a,@z.a-@x.a,-d.a,@y.b-@x.b,@z.b-@x.b,-d.b,@y.c-@x.c,@z.c-@x.c,-d.c).calcular_matriz()
        beta=(Matriz.new(e.a-@x.a,@z.a-@x.a,-d.a,e.b-@x.b,@z.b-@x.b,-d.b,e.c-@x.c,@z.c-@x.c,-d.c).calcular_matriz())/m
        gama=(Matriz.new(@y.a-@x.a,e.a-@x.a,-d.a,@y.b-@x.b,e.b-@x.b,-d.b,@y.c-@x.c,e.c-@x.c,-d.c).calcular_matriz())/m
        t=(Matriz.new(@y.a-@x.a,@z.a-@x.a,e.a-@x.a,@y.b-@x.b,@z.b-@x.b,e.b-@x.b,@y.c-@x.c,@z.c-@x.c,e.c-@x.c).calcular_matriz())/m
        if beta > 0.0
            if gama > 0.0
                if beta+gama < 1.0
                    return t
                else
                    return Float::INFINITY
                end
            else
                return Float::INFINITY
            end
        else
            return Float::INFINITY
        end
    end

end