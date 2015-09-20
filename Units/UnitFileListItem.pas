unit UnitFileListItem;

interface

uses Classes, Windows, SysUtils, Messages, StrUtils, Generics.Collections;

type
  TSplitType = (stIntoParts, stAccordingToDuration);

type
  TFileListItem = class
    FullFilePath: string;
    SplitType: TSplitType;
    PartsCount: integer;
    DurationLength: Integer;
    DurationAsString: string;
    DurationAsInt: integer;
    SplitMinute: integer;
    SplitSecond: integer;
    SplitMiliSeconds: integer;
  end;
  TFileListItems = TList<TFileListItem>;

implementation

end.
