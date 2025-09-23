pragma Ada_2022;

with Ada.Containers;

--  with VSS.Strings.Conversions;

with GNATdoc.Entities; use GNATdoc.Entities;
with Streams;
with VSS.Strings;

package body GNATdoc.Backend.PUML is

   --  procedure Generate_Documentation
   --    (Self   : in out PUML_Backend'Class;
   --     Entity : Entity_Information);
   --  ?? Generate PUML file for given entity.

   procedure Append_Package_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information);
      --  Entity : not null Entity_Information_Access);
   --  Append documentation to package diagram for given entity.

   procedure Append_Class_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information;
      File   : in out Streams.Output_Text_Stream);
      --  Entity : not null Entity_Information_Access);
   --  Append documentation to class diagram for given entity.

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
      --  [+] Open files
      --  [*] Process and separate, call subprograms
      --  [+] Close files

      --  Open output files.
      File_Classes.Open (Name_Classes);
      File_Packages.Open (Name_Packages);

      --  TODO: ?? Extract procedure: startuml classes, packages ??
      File_Classes.Put ("@startuml", Success);
      File_Classes.Put_Line (" classes", Success);
      File_Classes.Put_Line ("set namespaceSeparator none", Success);
      File_Classes.New_Line (Success);

      File_Packages.Put ("@startuml", Success);
      File_Packages.Put_Line (" packages", Success);
      File_Packages.Put_Line ("set namespaceSeparator none", Success);
      File_Packages.New_Line (Success);

      --  FIXME: Packages.
      for Item of Globals.Packages loop
         if not Is_Private_Entity (Item) then
            Self.Append_Package_Diagram (Item.all);
            --  FIXME: make choice for public, private, body?
            --
            --  File_Pkg.New_Line (Success);  -- FIXME:
         end if;
      end loop;

      -------------
      -- Classes --
      -------------

      for Item of Globals.Interface_Types loop
         --  if not Is_Private_Entity (Item) then
         --     Class_Index_Entities.Insert (Item);
         --  end if;
            Self.Append_Class_Diagram (Item.all, File_Classes);
            --  FIXME: make choice for public, private, body?
            --
            File_Classes.New_Line (Success);
      end loop;

      for Item of Globals.Tagged_Types loop
         --  if not Is_Private_Entity (Item) then
         --     Class_Index_Entities.Insert (Item);
         --  end if;
            Self.Append_Class_Diagram (Item.all, File_Classes);
            --  FIXME: make choice for public, private, body?
            --
            File_Classes.New_Line (Success);
      end loop;

      File_Classes.Put_Line ("@enduml", Success);
      --  File_Classes.New_Line (Success);

      File_Packages.Put_Line ("@enduml", Success);
      --  File_Packages.New_Line (Success);

      --  Close output files.
      File_Classes.Close;
      File_Packages.Close;
   end Generate;

   ----------------------------
   -- Append_Package_Diagram --
   ----------------------------

   procedure Append_Package_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information)
   is
   begin
      null; --  FIXME:
   end Append_Package_Diagram;

   --------------------------
   -- Append_Class_Diagram --
   --------------------------

   procedure Append_Class_Diagram
     (Self   : in out PUML_Backend'Class;
      Entity : Entity_Information;
      File   : in out Streams.Output_Text_Stream)
   is
      Success : Boolean := True;
      --  Nested : Entity_Information_Sets.Set;
   begin
      --  FIXME: Bellow is samples.
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

      --  FIXME: Print debug.
      --  File.Put (Entity.Qualified_Name, Success);
      --  File.Put (" ", Success);
      --  File.Put
      --    (VSS.Strings.To_Virtual_String (Entity.Kind'Wide_Wide_Image), Success);
      --  File.New_Line (Success);

      --  Note: | - or, [..] - optional element
      --
      --  abstract|class|entity|enum|interface|record|struct Qualified_Name \
      --   [as Aliased_Name] [<< (), Label_Info >>] {
      --   ' {field}, {method} are optional.
      --   ' You can use {field} and {method} modifiers to override default
      --   ' behaviour of the parser about fields and methods.
      --
      --      + {field} Public_Field_1 : String
      --      + {method} Public_Method_1 (Arg_1 : String) -> String
      --
      --      __private__
      --      # {field} Private_Field_2 : String
      --      # {field} Color : HTML_Color
      --      # {field} Aggregation : Aggregated
      --      # {field} Composition : Composed
      --      # {method} Private_Method_2 (Arg_1 : String) -> String
      --
      --      --body--
      --      - {method} Body_Method_3 (Arg_1 : String) -> String
      --  }

      if Entity.Kind = Ada_Tagged_Type or
        Entity.Kind = Ada_Interface_Type
      then
      --  FIXME: ^ - May be like redundand check.
      --
         if Entity.Kind = Ada_Tagged_Type then
         --  if `Entity.F_Has_Abstract` then
            --  FIXME: ?? How to check `Entity.F_Has_Abstract` ??
            --  File.Put ("abstract ", Success);
         --  else
            File.Put ("class ", Success);
         --  end if;
         elsif Entity.Kind = Ada_Interface_Type then
            File.Put ("interface ", Success);
         end if;

         File.Put (Entity.Qualified_Name."&" (" "), Success);
         File.Put ("as """, Success);
         --  File.Put (To_Entity (Entity.Enclosing).Name, Success);
         File.Put (To_Entity (Entity.Enclosing).Name_Suffix, Success);
         --  FIXME: For empty Enclosing Name_Suffix (Name_Prefix), use
         --  Enclosing Name.
         File.Put (".", Success);
         File.Put (Entity.Name."&" (""" "), Success);

         File.Put ("<< namespace: ", Success);
         File.Put (To_Entity (Entity.Enclosing).Name_Prefix, Success);
         File.Put (". >> ", Success);

         if not Entity.Parent_Type.Qualified_Name.Is_Empty then
            File.Put ("extends ", Success);
            File.Put (Entity.Parent_Type.Qualified_Name."&" (" "), Success);
         end if;

         declare
            use Ada.Containers;
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

         File.Put ("{", Success);  -- Begin scope.
         File.New_Line (Success);

         --  TODO: Increase the indent.

         for Method of Entity.Belongs_Subprograms loop
            File.Put ("+ {method} ", Success);
            --  File.Put_Line
            --    (To_Entity.Element (Method.Signature).RST_Profile, Success);
            File.Put_Line
              (To_Entity.Element (Method.Signature).PUML_Profile, Success);
         end loop;

         --  TODO: Sections private, body.

         --  TODO: Decrease the indent.

         File.Put_Line ("}", Success);  -- End scope.

      end if;
   end Append_Class_Diagram;

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
