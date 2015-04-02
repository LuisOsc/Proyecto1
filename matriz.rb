class Matriz
	attr_accessor :a11
	attr_accessor :a12
	attr_accessor :a13
	attr_accessor :a21
	attr_accessor :a22
	attr_accessor :a23
	attr_accessor :a31
	attr_accessor :a32
	attr_accessor :a33

	def initialize(a11=0.0,a12=0.0,a13=0.0,a21=0.0,a22=0.0,a23=0.0,a31=0.0,a32=0.0,a33=0.0)
		@a11=a11
		@a12=a12
		@a13=a13
		@a21=a21
		@a22=a22
		@a23=a23
		@a31=a31
		@a32=a32
		@a33=a33
    end

    def calcular_matriz()
    	diagonales_positivas=(a11*a22*a33)+(a12*a23*a31)+(a21*a32*a13)
        diagonales_negativas=(a13*a22*a31)+(a23*a32*a11)+(a12*a21*a33)
        return diagonales_positivas-diagonales_negativas
    end

end