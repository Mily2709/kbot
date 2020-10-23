class Factura
    def initialize(cantidad, precioUnitario, estado)
        @impuestos = {"ut" => [0.0685], "nv" => [0.08], "tx" => [0.0625], "al" => [0.04], "ca" => [0.0825]}
        @descuentos ={1000 => 0.03, 5000 => 0.05, 7000 => 0.07,10000 => 0.10, 50000 => 0.15}
        estado ||= "ut"
        @estado = estado.downcase
        @cantidad = cantidad.to_i
        @precioUnitario = precioUnitario.to_f
    end

    def cantidad
        @cantidad
    end 

    def precio
        @precioUnitario
    end 
    def printFactura()
        "Cantidad".ljust(12)+ "Precio unitario".ljust(20)+"\n#{@cantidad}".ljust(12)+"#{@precioUnitario}".rjust(20)+
        "\nTipo Impuesto: #{@estado}"
    end
    def printImpuestosYDescuentos()
        "impuestos: #{@impuestos} ,\nDescuentos: #{@descuentos} "
    end

    def subtotal()
        @cantidad*@precioUnitario
    end
  
    def descuento()
        tasa= @descuentos[@descuentos.select{|monto,tasa| subtotal()>=monto}.keys.max].to_f
        subtotal()*tasa
    end

    def precioConDescuento()
        return  subtotal()-descuento()
    end

    def impuesto()
        precioConDescuento()*(@impuestos[@estado][0])
    end


    def total()
        precioConDescuento()+impuesto()
    end
end


factura = Factura.new(ARGV[0], ARGV[1], ARGV[2]);
puts factura.printImpuestosYDescuentos()
puts factura.printFactura()
puts "Subtotal (#{factura.cantidad}*#{factura.precio}): #{factura.subtotal}".rjust(31)
puts "Descuento: #{factura.descuento}".rjust(31)
puts "Precio con Descuento:  #{factura.precioConDescuento}".rjust(31)
puts "impuesto: #{factura.impuesto}".rjust(31)
puts "Total:  #{factura.total}".rjust(31)

