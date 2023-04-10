#include 'protheus.ch'

USER FUNCTION EXERC17()

    LOCAL nNota1 := 0
    LOCAL nNota2 := 0
    LOCAL nMedia := 0
    LOCAL cSair  := "S"

  while cSair == "s" .or. cSair == "S"
    
        nNota1 := Val(FWInputBox("Digite o valor da 1° nota: "))
        nNota2 := Val(FWInputBox("Digite o valor da 2° nota: "))

        if nNota1 >= 0 .and. nNota1 <=10

            if nNota2 >=0 .and. nNota2 <=10 
                nMedia := (nNota1 + nNota2) / 2
                FWAlertSucess("A nota final foi de: " + alltrim(str(nMedia)))

            else 
                fwalertinfo("Nota 2 infomada incorretamente, favor tentar novamente")
            ENDIF
        else
            fwalertinfo("Nota 1 infomada incorretamente, favor tentar novamente")
            ENDIF

        cSair := FWInputBox("Novo Cálculo", "S- sim, N- Não" )

    ENDDO
   
RETURN
