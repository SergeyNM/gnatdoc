package GNATdoc.Backend.PUML is

   type PUML_Backend is new Abstract_Backend with private;

private

   type PUML_Backend is new Abstract_Backend with record
      OOP_Mode : Boolean := True; --  FIXME: constant?
   end record;

   overriding procedure Initialize (Self : in out PUML_Backend);

   overriding procedure Generate (Self : in out PUML_Backend);

   overriding procedure Add_Command_Line_Options
     (Self   : PUML_Backend;
      Parser : in out VSS.Command_Line.Parsers.Command_Line_Parser'Class)
     is null;
   --  FIXME: Don't register any options, non-OOP style is not supported in the
   --  PUML backend.

   overriding procedure Process_Command_Line_Options
     (Self   : in out PUML_Backend;
      Parser : VSS.Command_Line.Parsers.Command_Line_Parser'Class)
     is null;
   --  FIXME: Don't register any options, non-OOP style is not supported in the
   --  PUML backend.

   overriding function Name
     (Self : in out PUML_Backend) return VSS.Strings.Virtual_String;

end GNATdoc.Backend.PUML;
