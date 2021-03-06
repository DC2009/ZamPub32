unit Plutil;

interface

uses Dialogs;

type
{Buttons}
  TPlMsgDlgBtn = (mbTak, mbNie, mbOk, mbAnuluj, mbPomoc, mbWszystko);
  TPlMsgDlgButtons = set of TPlMsgDlgBtn;

const
{Dates}
  plShortDayNames:array[1..7] of string[3]=
                  ('Nie','Pon','Wto','�ro','Czw','Pi�','Sob');

  plLongDayNames:array[1..7] of string[15]=
                 ('Niedziela','Poniedzia�ek','Wtorek','�roda','Czwartek','Pi�tek','Sobota');

  plLongMonthNames:array[1..12] of string[15]=
                   ('Stycze�','Luty','Marzec','Kwiecie�','Maj','Czerwiec','Lipiec',
                    'Sierpie�','Wrzesie�','Pa�dziernik','Listopad','Grudzie�');

  plShortMonthNames:array[1..12] of string[3]=
                    ('Sty','Lut','Mar','Kwi','Maj','Cze','Lip','Sie','Wrz','Pa�','Lis','Gru');

  implementation

end.
