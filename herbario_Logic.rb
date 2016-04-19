# encoding: UTF-8
#Se va a basar en un desplegable que permita seleccionar ingredientes, un buscador, y un panel de visualización de stats. 
#Tiene que poder manejar archivos de datos YAML

#Plantilla de los datos. Múltiples arrays [nombre, valor, peso, ing1, ing2, ing3, ing4] convertidos a YAML

require 'yaml'
class Ingrediente
	def initialize
		cargar_DB
	end

	def cargar_DB
		File.open( 'herbarioDB.yml') { |ing|
			@lista_array = YAML.load(ing)
		}
	end

	def añadir_ingrediente(nombre, valordw, valordr, valordv, valorpq, peso, ef1, ef2, ef3, ef4)
		@ingrediente_nuevo = [nombre.capitalize, valordw, valordr, valordv, valorpq, peso, ef1.capitalize, ef2.capitalize, ef3.capitalize, ef4.capitalize]
		@lista_array << @ingrediente_nuevo
		@lista_array_sorted = @lista_array.sort { 
			|a,b| a[0].downcase <=> b[0].downcase
		}
#		puts @lista_array_sorted
		File.open( "herbarioDB.yml", 'w' ) {
      |f|
      f.write(@lista_array_sorted.to_yaml)
    }
    cargar_DB
=begin   	
    
   	file_names = ["herbarioDB.yml"]
		file_names.each do |file_name|
	 	text = File.read(file_name)
	 	new_contents = text.gsub(/cp850/, "utf-8")
	  File.open(file_name, "w") {
	  	|file| file.puts new_contents 
	  }
		end
=end		


	end

	def editar_ingrediente(nombre, valordw, valordr, valordv, valorpq, peso, ef1, ef2, ef3, ef4)
		for i in @lista_array
			if nombre == i[0]
				@lista_array.delete(i)
			end
		end
		añadir_ingrediente(nombre, valordw, valordr, valordv, valorpq, peso, ef1, ef2, ef3, ef4)
	end

  def get_nombre
  	@nombres_mostrar = []
  	for i in @lista_array
  		@nombres_mostrar << i[0]  		
  	end
 	return @nombres_mostrar
  end

	def get_detalles(index)
		ind = index
		for i in @lista_array
			if @lista_array[ind].first == i[0]
				@got_detalles = i 
			end
		end
		return @got_detalles
	end
	def get_for_delete(index)
		ind = index
		for i in @lista_array
			if @lista_array[ind].first == i[0]
				@lista_array.delete_at(ind)
				File.open( "herbarioDB.yml", 'w' ) {
        |f|
        f.write(@lista_array.to_yaml)
    		}
				cargar_DB
			end
		end
		
	end
end

