#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CriaPasta
    1 � Desenvolva um programa que criar� um
    diret�rio chamado �Lista 13 � Ex1� na pasta
    tempor�ria do Windows.
    @type  Function
    @author Giulliana Yamaguchi
    @since 24/04/2023
    /*/
User Function CriaPasta()
  Local cCaminho   := 'C:\Users\Giulliana Yamaguchi\AppData\Local\Temp\' //? Endere�o onde a pasta ser� criada
  Local cNomePasta := 'Lista 13�Ex2\' //? Nome da pasta que ser� criada
  //? Verificando se a pasta j� existe
  if !ExistDir(cCaminho + cNomePasta)
    //? Criando a pasta
    if MakeDir(cCaminho + cNomePasta) == 0
      //? Chamando a fun��o que criar� um arquivo de texto dentro da pasta criada.

      if ExistBlock('EscrCSV')
        ExecBlock('EscrCSV', .F., .F., cCaminho + cNomePasta)
      endif
    else
      FwAlertError('Houve um erro ao criar a pasta ' + cNomePasta, 'Aten��o')
    endif
  else
    if ExistBlock('EscrCSV')
      ExecBlock('EscrCSV', .F., .F., cCaminho + cNomePasta)
    endif
  endif
Return
