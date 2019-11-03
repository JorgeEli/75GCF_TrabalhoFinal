object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 290
  Width = 574
  object Connection: TFDConnection
    Params.Strings = (
      'Password=masterkey'
      'User_Name=SYSDBA'
      'DriverID=FB'
      
        'Database=C:\Git\75GCF_TrabalhoFinal\DataBase\MERCADO_DELIVERY.FD' +
        'B')
    Connected = True
    LoginPrompt = False
    Transaction = Transaction
    Left = 56
    Top = 40
  end
  object Transaction: TFDTransaction
    Connection = Connection
    Left = 136
    Top = 40
  end
  object Driver: TFDPhysFBDriverLink
    Left = 216
    Top = 41
  end
end
