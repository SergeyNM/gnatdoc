package body GNATdoc.Backend.PUML_Markup is

   type PUML_Markup_Builder is tagged record
   --    limited new Markdown.Blocks.Visitors.Block_Visitor
   --      and Markdown.Inlines.Visitors.Annotated_Text_Visitor
   --  with record
      Output : VSS.String_Vectors.Virtual_String_Vector;

      Image  : Boolean := False;
      Text   : VSS.Strings.Virtual_String;
   end record;

   procedure Write
     (Self : in out PUML_Markup_Builder'Class;
      Text : VSS.Strings.Virtual_String);

   procedure Write_Line
     (Self : in out PUML_Markup_Builder'Class;
      Text : VSS.Strings.Virtual_String);

   procedure Write_New_Line (Self : in out PUML_Markup_Builder'Class);

   ------------------
   -- Build_Markup --
   ------------------

   function Build_Markup
     (Text : VSS.String_Vectors.Virtual_String_Vector)
      return VSS.String_Vectors.Virtual_String_Vector is
   begin
      return Text;
      --  FIXME: It is a stub
   end Build_Markup;

   -----------
   -- Write --
   -----------

   --  FIXME: `Write` subprograms is Copy-Paste from RST_Markup. Make base type
   --  for RST, PUML Markup_Builders and move methods to base type?
   procedure Write
     (Self : in out PUML_Markup_Builder'Class;
      Text : VSS.Strings.Virtual_String)
   is
      Line : VSS.Strings.Virtual_String := Self.Output.Last_Element;

   begin
      Line.Append (Text);
      Self.Output.Replace (Self.Output.Last_Index, Line);
   end Write;

   --------------------
   -- Write_New_Line --
   --------------------

   procedure Write_New_Line (Self : in out PUML_Markup_Builder'Class) is
   begin
      Self.Output.Append (VSS.Strings.Empty_Virtual_String);
   end Write_New_Line;

   ----------------
   -- Write_Line --
   ----------------

   procedure Write_Line
     (Self : in out PUML_Markup_Builder'Class;
      Text : VSS.Strings.Virtual_String) is
   begin
      Self.Write (Text);
      Self.Write_New_Line;
   end Write_Line;

end GNATdoc.Backend.PUML_Markup;
