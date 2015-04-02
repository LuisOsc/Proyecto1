require './Vector3'

class Camara
	attr_accessor :e 
	attr_accessor :up
	attr_accessor :pv
	attr_accessor :fov #angulo de vision (field to view)
	attr_accessor :df

	def initialize(e=Vector3.new,up=Vector3.new,pv=Vector3.new,fov=0.0,df=0.0)
		@e=e
		@up=up
		@pv=pv
		@fov=(fov * Math::PI/180)
		@df=df
	end

	def calcular_u() #u , v , w se actualizaw
		vxw = calcular_v.producto_vectorial(calcular_w)
		mod = vxw.modulo()
		return Vector3.new(vxw.a/mod,vxw.b/mod,vxw.c/mod)
	end

	def calcular_v()
        mod = @up.modulo()
		return Vector3.new(@up.a/mod,@up.b/mod,@up.c/mod)
	end

	def calcular_w()
		dv = @pv.resta(@e)
        mod = dv.modulo()
		return Vector3.new(-dv.a/mod,-dv.b/mod,-dv.c/mod)
	end

	def calcular_d(i,j,width,height)
        t = @df * (Math::tan(@fov/2))
		b = -t
		r = (width*t/height)
		l = -r
		u = l + (r-l)*(i + 0.5)/width
		v = b + (t-b)*(j + 0.5)/height

		dw = calcular_w().produc_valor_vector(-@df)
		uu = calcular_u().produc_valor_vector(u)
		vv = calcular_v().produc_valor_vector(v)

        return dw.suma(uu).suma(vv)
	end

end
