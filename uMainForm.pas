unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FMX.Memo.Types, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.ListBox, FMX.StdCtrls, FMX.Layouts, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, REST.Types,
  FMX.Edit, FMX.Effects, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.EditBox, FMX.ComboTrackBar, FMX.ComboEdit,
  FMX.ListView, FMX.TabControl, System.Threading,
   FMX.MultiView, FMX.Grid.Style, Fmx.Bind.Grid,
  Data.Bind.Controls, Fmx.Bind.Navigator, Data.Bind.Grid, FMX.Grid;

type
  TMainForm = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    InputMemo: TMemo;
    PromptMemo: TMemo;
    MaterialOxfordBlueSB: TStyleBook;
    OutputMemo: TMemo;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ToolBar1: TToolBar;
    ShadowEffect4: TShadowEffect;
    Label1: TLabel;
    APIKeyButton: TButton;
    OAAPIKeyEdit: TEdit;
    StatusBar1: TStatusBar;
    ComposeButton: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    RequestVariationButton: TButton;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    BindSourceDB4: TBindSourceDB;
    StatusLabel: TLabel;
    BindSourceDB5: TBindSourceDB;
    TabControl2: TTabControl;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    HistoryGrid: TStringGrid;
    HistoryMT: TFDMemTable;
    BindSourceDB6: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB6: TLinkGridToDataSource;
    BindNavigator1: TBindNavigator;
    Layout8: TLayout;
    ModelsMT: TFDMemTable;
    BindSourceDB7: TBindSourceDB;
    ProgressBar: TProgressBar;
    Timer: TTimer;
    Splitter1: TSplitter;
    LoadRecordButton: TButton;
    APIKeyEdit: TEdit;
    RESTClient2: TRESTClient;
    RESTResponse2: TRESTResponse;
    RESTRequest2: TRESTRequest;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    FDMemTable2: TFDMemTable;
    RESTClient3: TRESTClient;
    RESTResponse3: TRESTResponse;
    RESTRequest3: TRESTRequest;
    RESTResponseDataSetAdapter3: TRESTResponseDataSetAdapter;
    FDMemTable3: TFDMemTable;
    PredictionMemo: TMemo;
    VersionEdit: TComboBox;
    LinkListControlToField1: TLinkListControlToField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LanguagesMT: TFDMemTable;
    LanguageCB1: TComboBox;
    LanguageCB2: TComboBox;
    Label5: TLabel;
    BindSourceDB8: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    Layout3: TLayout;
    LoadButton: TButton;
    OpenDialog: TOpenDialog;
    procedure APIKeyButtonClick(Sender: TObject);
    procedure ComposeButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure RequestVariationButtonClick(Sender: TObject);
    procedure OutputMemoChange(Sender: TObject);
    procedure LoadRecordButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HistoryGridResize(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
  private
    { Private declarations }
    function CreateOpenAIChatJSON(const AModel, APrompt: string; AMaxTokens: Integer): string;
    function CreateReplicateJSON(const AVersion, APrompt: string): string;
  public
    { Public declarations }
    FVariation: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.JSON, System.IOUtils, StrUtils;



function TMainForm.CreateOpenAIChatJSON(const AModel, APrompt: string; AMaxTokens: Integer): string;
var
  RootObj, SystemMessageObj, UserMessageObj: TJSONObject;
  MessagesArray: TJSONArray;
begin
  RootObj := TJSONObject.Create;
  try
    RootObj.AddPair('model', AModel);

    MessagesArray := TJSONArray.Create;
    try
      SystemMessageObj := TJSONObject.Create;
      SystemMessageObj.AddPair('role', 'system');
      SystemMessageObj.AddPair('content', 'You are the best written and spoken language expert in the world and know how to translate text between all languages.');
      MessagesArray.AddElement(SystemMessageObj);

      //if OutPutMemo.Lines.Text='' then
      begin
        UserMessageObj := TJSONObject.Create;
        UserMessageObj.AddPair('role', 'user');
        UserMessageObj.AddPair('content', APrompt);
        MessagesArray.AddElement(UserMessageObj);
      end;

      if FVariation=True then
      begin
        if OutPutMemo.Lines.Text<>'' then
        begin
          UserMessageObj := TJSONObject.Create;
          UserMessageObj.AddPair('role', 'assistant');
          UserMessageObj.AddPair('content', OutPutMemo.Lines.Text);
          MessagesArray.AddElement(UserMessageObj);
        end;

        if OutPutMemo.Lines.Text<>'' then
        begin
          UserMessageObj := TJSONObject.Create;
          UserMessageObj.AddPair('role', 'user');
          UserMessageObj.AddPair('content', 'Take another look and refine the translation. Fix any mistakes.');
          MessagesArray.AddElement(UserMessageObj);
        end;
      end;

      RootObj.AddPair('messages', MessagesArray);
    except
      MessagesArray.Free;
      raise;
    end;

  //  RootObj.AddPair('max_tokens', TJSONNumber.Create(AMaxTokens));

    Result := RootObj.Format(2); // The number 2 is to specify the formatting indent size
  finally
    RootObj.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  var LFilePath := TPath.Combine(TPath.GetDocumentsPath,'aitranslate.fds');
  if TFile.Exists(LFilePath) then
  begin
    HistoryMT.LoadFromFile(LFilepath);
    HistoryGridResize(Sender);
  end;

  LanguageCB1.ItemIndex := 0;
  LanguageCB2.ItemIndex := 22;
end;

procedure TMainForm.HistoryGridResize(Sender: TObject);
begin
  if HistoryGrid.ColumnCount>0 then
    for var I := 0 to HistoryGrid.ColumnCount-1 do
    begin
      HistoryGrid.Columns[I].Width := Trunc(Trunc(HistoryGrid.Width) / HistoryGrid.ColumnCount);
    end;
end;

procedure TMainForm.LoadButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    InputMemo.Lines.LoadFromFile(OpenDialog.Filename);
end;

procedure TMainForm.LoadRecordButtonClick(Sender: TObject);
begin
  PromptMemo.Lines.Text := HistoryMT.FieldByName('PromptText').AsWideString;
  InputMemo.Lines.Text := HistoryMT.FieldByName('InputText').AsWideString;
  OutputMemo.Lines.Text := HistoryMT.FieldByName('OutputText').AsWideString;
end;

procedure TMainForm.OutputMemoChange(Sender: TObject);
begin
  if OutputMemo.Lines.Text<>'' then
    RequestVariationButton.Enabled := True
  else
    RequestVariationButton.Enabled := False;
end;

procedure TMainForm.RequestVariationButtonClick(Sender: TObject);
begin
  FVariation := True;
  RequestVariationButton.Enabled := False;
  ComposeButtonClick(Sender);
end;

procedure TMainForm.APIKeyButtonClick(Sender: TObject);
begin
  APIKeyEdit.Visible := not APIKeyEdit.Visible;
  OAAPIKeyEdit.Visible := not OAAPIKeyEdit.Visible;
end;

function GetMessageContent(const JSONArray: string): string;
var
  JSONData: TJSONArray;
  MessageObj: TJSONObject;
begin
  Result := '';
  JSONData := TJSONObject.ParseJSONValue(JSONArray) as TJSONArray;
  try
    MessageObj := (JSONData.Items[0] as TJSONObject).GetValue<TJSONObject>('message');
    Result := MessageObj.GetValue<string>('content');
  finally
    JSONData.Free;
  end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  if ProgressBar.Visible = False then
  begin
    Timer.Enabled := False;
  end
  else
  begin
    if ProgressBar.Value=ProgressBar.Max then
      ProgressBar.Value := ProgressBar.Min
    else
      ProgressBar.Value := ProgressBar.Value+5;
  end;
end;


function ConcatJSONStrings(const JSONArray: string): string;
var
  JSONData: TJSONArray;
  I: Integer;
begin
  if JSONArray[1]='[' then
  begin

  Result := '';
  JSONData := TJSONObject.ParseJSONValue(JSONArray) as TJSONArray;
  try
    for I := 0 to JSONData.Count - 1 do
      Result := Result + JSONData.Items[I].Value;
  finally
    JSONData.Free;
  end;
  end
  else
  Result := JSONArray;
end;


function TMainForm.CreateReplicateJSON(const AVersion, APrompt: string): string;
var
  RootObj, InputObj: TJSONObject;
begin
  RootObj := TJSONObject.Create;
  try
    RootObj.AddPair('version', AVersion);

    InputObj := TJSONObject.Create;
    try
      var LPrompt := '';

      if FVariation=True then
      begin
        LPrompt := APrompt + ' Here is a translation: ' + OutPutMemo.Lines.Text + ' Take another look at the above text and refine the translation.';
      end
      else
      begin
        LPrompt := APrompt;
      end;


      InputObj.AddPair('prompt', LPrompt);
     // InputObj.AddPair('max_tokens', TJSONNumber.Create(AMaxTokens));

      RootObj.AddPair('input', InputObj);
    except
      InputObj.Free;
      raise;
    end;

    Result := RootObj.ToString;
  finally
    RootObj.Free;
  end;
end;

procedure TMainForm.ComposeButtonClick(Sender: TObject);
begin
  if ((OAAPIKeyEdit.Text='') and (ModelsMT.FieldByName('provider').AsWideString='openai')) then
  begin
    ShowMessage('Enter an OpenAI.com API key.');
    Exit;
  end;

  if ((APIKeyEdit.Text='') and (ModelsMT.FieldByName('provider').AsWideString='replicate')) then
  begin
    ShowMessage('Enter a Replicate.com API key.');
    Exit;
  end;


  ComposeButton.Enabled := False;
  ProgressBar.Visible := True;
  Timer.Enabled := True;

  TTask.Run(procedure begin
    if ModelsMT.FieldByName('provider').AsWideString='openai' then
    begin
      RESTRequest1.Params[0].Value := 'Bearer ' + OAAPIKeyEdit.Text;
      RESTRequest1.Params[1].Value := CreateOpenAIChatJSON(VersionEdit.Selected.Text, PromptMemo.Lines.Text.Replace('%input%',LanguageCB1.Selected.Text).Replace('%output%',LanguageCB2.Selected.Text) + ' ' + InputMemo.Lines.Text, 2000);
      RESTRequest1.Execute;

      if FDMemTable1.FindField('choices')<>nil then
      begin
        TThread.Synchronize(nil,procedure begin
          OutputMemo.Lines.Text := GetMessageContent(FDMemTable1.FieldByName('choices').AsWideString);

          StatusLabel.Text := FDMemTable1.FieldByName('usage').AsWideString;

          RequestVariationButton.Enabled := True;

          HistoryMT.AppendRecord([PromptMemo.Lines.Text, InputMemo.Lines.Text, OutputMemo.Lines.Text]);

          HistoryMT.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,'aitranslate.fds'));
        end);
      end;
    end
    else if ModelsMT.FieldByName('provider').AsWideString='replicate' then
    begin
      RESTRequest2.Params[0].Value := 'Token ' + APIKeyEdit.Text;
      RESTRequest2.Params[1].Value := CreateReplicateJSON(ModelsMT.FieldByName('model').AsWideString, PromptMemo.Lines.Text.Replace('%input%',LanguageCB1.Selected.Text).Replace('%output%',LanguageCB2.Selected.Text) + ' "' + InputMemo.Lines.Text + '"');
      RESTRequest2.Execute;

      if FDMemTable2.FindField('id')<>nil then
      begin
         var LStatus := 'started';
         while ((LStatus<>'succeeded') AND (LStatus<>'failed')) do
         begin
           RESTRequest3.Resource := FDMemTable2.FieldByName('id').AsWideString;
           RESTRequest3.Params[0].Value := 'Token ' + APIKeyEdit.Text;
           RESTRequest3.Execute;
           LStatus := FDMemTable3.FieldByName('status').AsWideString;

           if LStatus='succeeded' then
           begin
             var LOutput := ConcatJSONStrings(FDMemTable3.FieldByName('output').AsWideString);
             if LOutput<>'' then
             begin
                TThread.Synchronize(nil,procedure begin
                  StatusLabel.Text := LStatus;
                  OutputMemo.Lines.Text := LOutput;

                  RequestVariationButton.Enabled := True;

                  HistoryMT.AppendRecord([PromptMemo.Lines.Text, InputMemo.Lines.Text, OutputMemo.Lines.Text]);

                  HistoryMT.SaveToFile(TPath.Combine(TPath.GetDocumentsPath,'aitranslate.fds'));
                end);

             end;
           end
           else
           begin
              TThread.Synchronize(nil,procedure begin
                 StatusLabel.Text := LStatus;
              end);
           end;

           Sleep(3000);

         end;
      end;

    end;

    TThread.Synchronize(nil,procedure begin
      ComposeButton.Enabled := True;
      ProgressBar.Visible := False;
    end);
    FVariation := False;
  end);
end;





end.
