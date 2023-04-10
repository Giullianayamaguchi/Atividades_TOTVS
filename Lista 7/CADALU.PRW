#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function CADALU
    Cadastro de alunos 
    @type  Function
    @author Giulliana Yamaguchi
    @since 27/03/2023
    /*/

User Function CADALU()
    Local cAlias  := 'ZZA'
    Local cTitle  := "Alunos"
    Local oMark   := FWMarkBrowse():New() 

    oMark:AddButton('Excluir Marc.',   'U_Apagar', 5, 1)
    
    oMark:SetAlias(cAlias) 
    oMark:SetDescription(cTitle)        

    oMark:SetFieldMark('ZZA_MARK')
    oMark:DisableDetails()   
    oMark:DisableReport()
    oMark:ACTIVATE()

Return 

STATIC FUNCTION MenuDef()
    Local aRotina :={}

    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CADALU' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CADALU' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Exluir'     ACTION 'VIEWDEF.CADALU' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local bModelPos:= {|oModel|MdlInst(oModel)}

    Local oModel := MPFormModel():NEW('CADALUM',, bModelPos)     
    Local oStruZZA := FWFormStruct(1,'ZZA')        

    Local aTrig    := FwStruTrigger('ZZA_CDINST','ZZA_NOMINS','ZZI->ZZI_NOME',.T.,'ZZI',1,'xFilial("ZZI")+Alltrim(M->ZZA_CDINST)') 
    
    oStruZZA:AddTrigger(aTrig[1],aTrig[2],aTrig[3],aTrig[4])        
    
    // Adiciona ao modelo um componente de formulário
    oModel:AddFields('ZZAMASTER', ,oStruZZA)
    oStruZZA:SetProperty('ZZA_COD', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'GetSXEnum("ZZA", "ZZA_COD")'))
 
    // Adiciona a descrição do Modelo de Dados
    oModel:SetDescription('Modelo de dados de Aluno')

    // Adiciona a descrição dos Componentes do Modelo de Dados
    oModel:GetModel('ZZAMASTER'):SetDescription('Formulario de aluno')
    oModel:SetPrimaryKey({'ZZA_COD'})

Return oModel

Static Function ViewDef()
    // Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
    Local oModel := FwLoadModel('CADALU')

    // Cria as estruturas a serem usadas na View
    Local oStruZZA := FWFormStruct(2, 'ZZA')
    Local oView  := FwFormview():New()

    oView:SetModel(oModel)

     // Adiciona no nosso View um controle do tipo formulário (antiga Enchoice)
    oView:AddField('VIEW_ZZA',oStruZZA, 'ZZAMASTER')       

    // Cria um "box" horizontal para receber cada elemento da view
    oView:CreateHorizontalBox('TELA', 100)

    // Relaciona o identificador (ID) da View com o "box" para exibição
    oView:SetOwnerView('VIEW_ZZA', 'TELA')

    oView:SetFieldAction('ZZA_AULAS', {|oView|ValidaAula(oView)})
    
Return oView

    // Adiciona a quantidade do aluno
Static Function MdlInst(oModel)

    // Cria as estruturas a serem usadas no Modelo de Dados
    Local lVali := FwFormCommit(oModel)
    Local nOpc := oModel:GetOperation()
    Local cInst := (oModel:GetValue('ZZAMASTER', 'ZZA_CDINST'))
    Local cVlTur := (oModel:GetValue('ZZAMASTER', 'ZZA_AULAS'))
    
    DBSELECTAREA( 'ZZI' )
    ZZI->(DBGOTOP())
    if lVali
        while ZZI->(!EOF()) //Enquanto nn foi fim de arquivo

        //valida se o o cod inserido é igual ao que existe no banco de dados
            if ZZI->ZZI_COD == cInst .and. cVlTur == "1-sim"
                Reclock('ZZI', .F.)

        //valida se o instrutor tem mais de 5 alunos
                if ZZI_QTDALU >= 5 
                    lVali := .F.
                    help(,,'erro',,'Favor revisar as informações', 1, 0,,,,,,{'Para iniciar aulas é necessário escolher o instrutor com menos de 5 alunos'})
                else
        
        //valida se a opção inserida foi ded incluir ou alterar
                    if nOpc == 3 .or. nOpc == 4
                       ZZI->ZZI_QTDALU += 1 

        //valida se a opção é de excluiar e se a opção de turma está como não participante
                    elseif nOpc == 5 .or. cVlTur == "2-não"
                        ZZI->ZZI_QTDALU -= 1
                    endif

                endif
                MSUNLOCK()
                
            endif
            ZZI->(DBSKIP())
        ENDDO
    endif
    ZZI->(DBCLOSEAREA())
    
Return lVali

User Function Apagar()

    if MsgYesNo('Confirma a exclusão dos cursos selecionados?')
        DbSelectArea('ZZA')
        
        ZZA->(DbGotop())
        
        while ZZA->(!EOF())
            if oMark:IsMark()  //? Verifica se o registro está marcado
                RecLock('ZZA', .F.)
                    ZZA->(DbDelete()) //? Marca o registro como Apagar (D_E_L_E_T_ = '*')
                ZZA->(MSUnlock())
            endif
            ZZA->(DbSkip())
        enddo
    endif
    //? Executa a atualização das informações no Browse
    oMark:Refresh(.T.) 
Return

Static Function ValidaAula(oView)
    Local cAula := alltrim(oView:GetValue('ZZAMASTER', 'ZZA_AULAS'))
    Local cIns  := alltrim(oView:GetValue('ZZAMASTER', 'ZZA_CDINST'))

    If cIns == '' .and. cAula == "1-sim"
        help(,,'erro',,'Favor revisar as informações', 1, 0,,,,,,{'Para iniciar aulas é necessário escolher o instrutor com menos de 5 alunos'})
    endif

Return
