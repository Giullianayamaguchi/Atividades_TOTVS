#INCLUDE "PROTHEUS.CH"

User Function Exerc39() 

    Local aNomesStart := {'Natan','Stephani','Daniele','','Edison','Ruan',;
                        'Gabriela','Giulliana','Quirino','João','Gustavo',;
                        'Tamíris','Pintor','Henrique','Lucas','Fábio'}
    Local nTamanho := 0
    Local cSorteado := ''

    nTamanho := LEN( aNomesStart ) 
    cSorteado := aNomesStart[RANDOMIZE(1,nTamanho)] 
    FWAlertSucess(cSorteado) 

Return

