#INCLUDE "PROTHEUS.CH"

User Function Exerc39() 

    Local aNomesStart := {'Natan','Stephani','Daniele','','Edison','Ruan',;
                        'Gabriela','Giulliana','Quirino','Jo�o','Gustavo',;
                        'Tam�ris','Pintor','Henrique','Lucas','F�bio'}
    Local nTamanho := 0
    Local cSorteado := ''

    nTamanho := LEN( aNomesStart ) 
    cSorteado := aNomesStart[RANDOMIZE(1,nTamanho)] 
    FWAlertSucess(cSorteado) 

Return

