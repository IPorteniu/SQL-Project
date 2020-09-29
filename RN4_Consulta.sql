USE DbHospedajeNeydita
GO

CREATE FUNCTION RESERVACION_DE_HABITACION()
RETURNS TABLE
AS
	RETURN
			(
				SELECT r.CReserva,rh.CHabitacion,r.FEstadia,r.CComprobante,r.DInicioEstadia,r.DFinEstadia,r.FCancelado
				FROM Reserva r
				INNER JOIN Reserva_Habitacion rh ON rh.CReserva = r.CReserva
			)
GO

SELECT * FROM DBO.RESERVACION_DE_HABITACION()
GO

CREATE PROCEDURE ConsultaDeRegistroDeHabitacion(@codreserva INT)
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.RESERVACION_DE_HABITACION() R
				WHERE R.CReserva=@codreserva AND R.CHabitacion IS NOT NULL AND R.FEstadia IS NOT NULL AND
					R.CComprobante IS NOT NULL AND R.DInicioEstadia IS NOT NULL AND R.DFinEstadia IS NOT NULL AND
					R.FCancelado IS NOT NULL)
	BEGIN
		SELECT * FROM dbo.RESERVACION_DE_HABITACION() R WHERE R.CReserva = @codreserva
		PRINT 'ES POBILE LA RESERVA DE HABITACIÓN'
	END
	ELSE
		PRINT 'NO ES POSIBLE LA RESERVA DE HABITACIÓN PORQUE ALGUNOS DATOS NO SE ENCUENTRAN COMPLETOS O LA RESERVA NO EXISTE'
END

EXEC ConsultaDeRegistroDeHabitacion @codreserva=6