#include "PROTHEUS.CH"

USER FUNCTION L2_E6()
    Local nNum_1 := 0 
    Local nNum_2 := 0
    Local nNum_3 := 0
    Local nNum_4 := 0

    nNum_1 := Val(FWINPUTBOX("Digite um n�mero"))
    nNum_2 := Val(FWINPUTBOX("Digite um n�mero"))
    nNum_3 := Val(FWINPUTBOX("Digite um n�mero"))
    nNum_4 := Val(FWINPUTBOX("Digite um n�mero"))

    if(nNum_1 % 2 ==0 ).and. (nNum_1 % 3 ==0)
        MSGALERT("o valor digitado " +alltrim(str(nNum_1)) + " � divis�vel por 2 e 3")
    else
        MSGALERT("o valor digitado " +alltrim(str(nNum_1)) + " n�o � divis�vel por 2 e 3")
    ENDIF

    if(nNum_2 % 2 ==0 ).and. (nNum_2 % 3 ==0)
        MSGALERT("o valor digitado " + alltrim(str(nNum_2)) + " � divis�vel por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_2)) + " n�o � divis�vel por 2 e 3")
    ENDIF

    if(nNum_3 % 2 ==0 ).and. (nNum_3 % 3 ==0)
        MSGALERT("o valor digitado "+alltrim(str(nNum_3)) + " � divis�vel por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_3)) + " n�o � divis�vel por 2 e 3")
    ENDIF

    if(nNum_4 % 2 ==0 ).and. (nNum_4 % 3 ==0)
        MSGALERT("o valor digitado " + alltrim(str(nNum_4)) + " � divis�vel por 2 e 3")
    else
        MSGALERT("o valor digitado " + alltrim(str(nNum_4)) +  " n�o � divis�vel por 2 e 3")
    ENDIF

RETURN NIL
