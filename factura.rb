class Factura
    def initialize(cantidad, precioUnitario, estado)
        @impuestos = {"ut" => [0.0685], "nv" => [0.08], "tx" => [0.0625], "al" => [0.04], "ca" => [0.0825]}
        @descuentos ={1000 => 0.03, 5000 => 0.05, 7000 => 0.07,10000 => 0.10, 50000 => 0.15}
        estado ||= "ut"
        @estado = estado.downcase
        @cantidad = cantidad.to_i
        @precioUnitario = precioUnitario.to_f
    end

    def printFactura()
        "Cantidad: #{@cantidad} ,  Precio unitario: #{@precioUnitario} , Tipo Impuesto:  #{@estado}"
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
puts "Subtotal:  #{factura.subtotal}"
puts "Descuento: #{factura.descuento}"
puts "Precio con Descuento:  #{factura.precioConDescuento}"
puts "impuesto: #{factura.impuesto}"
puts "Total:  #{factura.total}"