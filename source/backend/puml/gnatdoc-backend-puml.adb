with Ada.Containers;

--  with VSS.Strings.Conversions;

with GNATdoc.Entities; use GNATdoc.Entities;
with Streams;

package body GNATdoc.Backend.PUML is

   --  procedure Generate_Documentation
   --    (Self   : in out PUML_Backend'Class;
   --     Entity : Entity_Information);
   --  ?? Generate PUML file for given entity.

   procedure Generate_Package_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information);
      --  Entity : not null Entity_Information_Access);
   --  Generate/Add documentation to package diagramm for given entity.

   procedure Generate_Class_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information;
      File   : in out Streams.Output_Text_Stream);
      --  Entity : not null Entity_Information_Access);
   --  Generate/Add documentation to class diamramm for given entity.

   --  OOP_Style_Option : constant VSS.Command_Line.Binary_Option :=
   --    (Short_Name  => <>,
   --     Long_Name   => "puml-oop-style",
   --     Description =>
   --       VSS.Strings.To_Virtual_String
   --       ("Group subprograms by tagged types, generating class-diagram with"
   --          & " tagged types"));
   --  FIXME: puml class-diagram is always OOP mode?
   --
   --  FIXME: Don't register any options, non-OOP style is not supported in the
   --  PUML backend.

   ------------------------------
   -- Add_Command_Line_Options --
   ------------------------------

   --  overriding procedure Add_Command_Line_Options
   --    (Self   : PUML_Backend;
   --   Parser : in out VSS.Command_Line.Parsers.Command_Line_Parser'Class) is
   --  begin
   --     Parser.Add_Option (OOP_Style_Option);
   --  end Add_Command_Line_Options;

   --------------
   -- Generate --
   --------------

   overriding procedure Generate (Self : in out PUML_Backend) is
      Name_Classes  : constant GNATCOLL.VFS.Virtual_File :=
        GNATCOLL.VFS.Create_From_Dir (Self.Output_Root, "classes.puml");
      Name_Packages : constant GNATCOLL.VFS.Virtual_File :=
        GNATCOLL.VFS.Create_From_Dir (Self.Output_Root, "packages.puml");
      File_Classes  : Streams.Output_Text_Stream;
      File_Packages : Streams.Output_Text_Stream;
      Success       : Boolean := True;
   begin
      --  classes.puml, packages.puml
      --
      --  FIXME: Generate workflow
      --  [R] Open files
      --  [ ] Analyse and separate, call subprograms
      --  [+] Close files

      --  Open output files.
      File_Classes.Open (Name_Classes);
      File_Packages.Open (Name_Packages);
      File_Classes.Put_Line ("@startuml", Success);
      File_Packages.Put_Line ("@startuml", Success);

      for Item of Globals.Packages loop
         if not Is_Private_Entity (Item) then
            Self.Generate_Class_Diagram (Item.all, File_Classes);
            --  FIXME: make choice for public, private, body?
            --
            File_Classes.New_Line (Success);

            Self.Generate_Package_Diagram (Item.all);
            --  FIXME: make choice for public, private, body?
            --
            --  File_Pkg.New_Line (Success);  -- FIXME:
         end if;
      end loop;

      File_Classes.Put_Line ("@enduml", Success);
      File_Classes.New_Line (Success);
      File_Packages.Put_Line ("@enduml", Success);
      File_Packages.New_Line (Success);
      --  Close output files.
      File_Classes.Close;
      File_Packages.Close;
   end Generate;

   ------------------------------
   -- Generate_Package_Diagram --
   ------------------------------

   procedure Generate_Package_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information)
   is
   begin
      null; --  FIXME:
   end Generate_Package_Diagram;

   ----------------------------
   -- Generate_Class_Diagram --
   ----------------------------

   procedure Generate_Class_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information;
      File   : in out Streams.Output_Text_Stream)
   is
      --  Name    : constant GNATCOLL.VFS.Virtual_File :=
      --    GNATCOLL.VFS.Create_From_Base
      --      (GNATCOLL.VFS.Filesystem_String
      --         (VSS.Strings.Conversions.To_UTF_8_String
      --            (Documentation_File_Name (Entity))),
      --       GNATdoc.Configuration.Provider.Output_Directory
      --         (Self.Name).Full_Name);
      --  Name    : constant GNATCOLL.VFS.Virtual_File :=
      --    GNATCOLL.VFS.Create_From_Base
      --      (GNATCOLL.VFS.Filesystem_String'("classes.puml"));
      --
      --  File    : Streams.Output_Text_Stream;
      Success : Boolean := True;

      --  Nested : Entity_Information_Sets.Set;
   begin
      --  FIXME: Bellow is sample

      --  Nested.Union (Entity.Formals);
      --  Nested.Union (Entity.Exceptions);
      --  Nested.Union (Entity.Simple_Types);
      --  Nested.Union (Entity.Array_Types);
      --
      --  Nested.Union (Entity.Record_Types);
      --  Nested.Union (Entity.Interface_Types);
      --  Nested.Union (Entity.Tagged_Types);
      --
      --  Nested.Union (Entity.Task_Types);
      --  Nested.Union (Entity.Protected_Types);
      --
      --  Nested.Union (Entity.Access_Types);
      --  Nested.Union (Entity.Subtypes);
      --
      --  Nested.Union (Entity.Constants);
      --  Nested.Union (Entity.Variables);

      --  Union (Nested, Entity.Belongs_Subprograms);
      --  Nested.Union (Entity.Subprograms);
      --
      --  Nested.Union (Entity.Entries);
      --  Nested.Union (Entity.Generic_Instantiations);
      --
      --  Nested.Union (Entity.Packages);
      --  Nested.Union (Entity.Package_Renamings);
      --  Nested.Union (Entity.Enclosing);

      --  error: type
      --  Nested.Union (Entity.Parent_Type);
      --  Entity.All_Parent_Types;

      --  error: type
      --  Nested.Union (Entity.Progenitor_Types);
      --  Entity.All_Progenitor_Types;

      --  error: type
      --  Nested.Union (Entity.Derived_Types);
      --  Entity.All_Derived_Types;

      --  FIXME:
      --  File.Put (Entity.Qualified_Name, Success);

      if Entity.Kind in Ada_Tagged_Type .. Ada_Interface_Type then
         if Entity.Kind = Ada_Tagged_Type then
         --  if `F_Has_Abstract` then
            --  FIXME: ?? How to check F_Has_Abstract ??
            --  File.Put ("abstract ", Success);
         --  else
            File.Put ("class ", Success);
         --  end if;
         elsif Entity.Kind = Ada_Interface_Type then
            File.Put ("interface ", Success);
         end if;

         File.Put (Entity.Qualified_Name."&" (" "), Success);

         if not Entity.Parent_Type.Qualified_Name.Is_Empty then
            File.Put ("extends ", Success);
            File.Put (Entity.Parent_Type.Qualified_Name."&" (" "), Success);
         end if;

         --  if not Entity.Progenitor_Types.Is_Empty then
         --     File.Put ("implements ", Success);
         --     for P of Entity.Progenitor_Types loop
         --        File.Put (P.Qualified_Name."&" (", "), Success);
         --     --  FIXME: Dont put ", " after last Progenitor. Put " ".
         --     end loop;
         --  end if;
         --
         declare
            use type Ada.Containers.Count_Type;
            Unprocessed_Progenitors : Count_Type :=
              Entity.Progenitor_Types.Length;
         begin
            if Unprocessed_Progenitors > 0 then
               File.Put ("implements ", Success);
               for Progenitor of Entity.Progenitor_Types loop
                  File.Put (Progenitor.Qualified_Name, Success);
                  if Unprocessed_Progenitors > 1 then
                     File.Put (", ", Success);
                  else
                     File.Put (" ", Success);
                  end if;
                  Unprocessed_Progenitors := @ - 1;
               end loop;
            end if;
         end;

--  {
--      ' {field}, {method} are optional.
--      ' You can use {field} and {method} modifiers to override default
--      ' behaviour of the parser about fields and methods.
--      + {field} Public_Field_1 : String
--      + {method} Public_Method_1 (Arg_1 : String) : String
--      __private__
--      # {field} Private_Field_2 : String
--      # {field} Color : HTML_Color
--      # {field} Aggregation : Aggregated
--      # {field} Composition : Composed
--      # {method} Private_Method_2 (Arg_1 : String) : String
--      --body--
--      - {method} Body_Method_3 (Arg_1 : String) : String
--  }

         File.Put ("{", Success);  -- Begin
         File.New_Line (Success);
      --
      --  + {field}
      --  + {method}
      --
      --  __private__
      --
      --  # {field}
      --  # {method}
      --
      --  --body--
      --  + {field}
      --  - {method}
      --
         File.Put ("}", Success);  -- End
      end if;

      --  File.Put_Lines (Success);
      File.New_Line (Success);

   end Generate_Class_Diagram;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out PUML_Backend) is
   begin
      Abstract_Backend (Self).Initialize;
   end Initialize;

   ----------
   -- Name --
   ----------

   overriding function Name
     (Self : in out PUML_Backend) return VSS.Strings.Virtual_String is
   begin
      return "puml";
   end Name;

   ----------------------------------
   -- Process_Command_Line_Options --
   ----------------------------------

   --  overriding procedure Process_Command_Line_Options
   --    (Self   : in out PUML_Backend;
   --     Parser : VSS.Command_Line.Parsers.Command_Line_Parser'Class) is
   --  begin
   --     if Parser.Is_Specified (OOP_Style_Option) then
   --        Self.OOP_Mode := True;
   --        --  FIXME: puml class-diagram is always OOP mode?
   --     end if;
   --  end Process_Command_Line_Options;
   --
   --  FIXME: Don't register any options, non-OOP style is not supported in the
   --  PUML backend.

end GNATdoc.Backend.PUML;
