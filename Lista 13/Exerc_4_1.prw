#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CriaPasta
    4 � Escreva um programa que criar� uma pasta
    com o nome �Lista 13� no rootpath
    (protheus_data) e copiar� o arquivo do
    exerc�cio 2 para essa pasta.
    @type  Function
    @author Giulliana Yamaguchi
    @since 24/04/2023
    /*/
    User Function CriaPasta()
    Local cCaminho   := 'C:\PROTHEUS1212210\protheus_data\' //? Endere�o onde a pasta ser� criada
    Local cNomePasta := 'Lista 13\' //? Nome da pasta que ser� criada
    
  //? Verificando se a pasta j� existe
  if !ExistDir(cCaminho + cNomePasta)
    //? Criando a pasta
    if MakeDir(cCaminho + cNomePasta) == 0
      //? Chamando a fun��o que criar� um arquivo de texto dentro da pasta criada.

      if ExistBlock('CopiaTXT')
        ExecBlock('CopiaTXT', .F., .F., cCaminho + cNomePasta)
      endif
    else
      FwAlertError('Houve um erro ao criar a pasta ' + cNomePasta, 'Aten��o')
    endif
  else
    if ExistBlock('CopiaTXT')
      ExecBlock('CopiaTXT', .F., .F., cCaminho + cNomePasta)
    endif
  endif
Return

