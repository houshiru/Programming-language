--  Author: Qi Mo, qmo2015@my.fit.edu
--  Author: Shiru Hou, shou2015@my.fit.edu
--  Course: CSE 4250, Fall 2017
--  Project: Proj3, Egyptian Hieroglyphs
--  Language Implementation: GNAT 20170515-63
with flood_fill; use flood_fill; with Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   type array_2D is array (Integer range <>, Integer range <>) of Character;
   H : Integer;    -- number of lines
   W : Integer;    -- number of pixels per line
   count : Integer := 0;
   caseCount : Integer := 0;
   temp : Character;
   copy_of_I : Integer;
   copy_of_J : Integer;
begin
   loop
      get (H);        -- reads H
      get (W);        -- reads W
      exit when H = 0 and W = 0;
      caseCount := caseCount + 1;
      declare
         myImage : image (0 .. H - 1, 0 .. W - 1);
      begin
         --  reads input character by character
         --  and store each character into the corresponding spot in myImage
            for I in myImage'Range (1) loop
               for J in myImage'Range (2) loop
                  Ada.Text_IO.get (temp);
                  myImage (I, J) := temp;
               end loop;
            end loop;
      -- calls white_fill precedure, flipping '0's that are not enclosed to 'G'
            white_fill (myImage, H, W, 1, 1);
            Ada.Text_IO.put ("case");
            put (caseCount);
            Ada.Text_IO.put (": ");
         --  loops through the image, once encounter a char that is not 'G',
         --  calls function count_enclosure to count the number of white area
         for J in myImage'Range (2) loop
               for I in myImage'Range (1) loop
                  if myImage (I, J) /= '0' and myImage (I, J) /= 'G' then
                     copy_of_I := I;
                     copy_of_J := J;
                     count := count_enclosure (count, H, W, copy_of_I,
                                         copy_of_J, myImage);
                  -- prints the result according to the number of enclosed white areas
                  if count = 0 then
                     Ada.Text_IO.put ('W');
                  elsif count = 1 then
                     Ada.Text_IO.put ('A');
                  elsif count = 2 then
                     Ada.Text_IO.put ('K');
                  elsif count = 3 then
                     Ada.Text_IO.put ('J');
                  elsif count = 4 then
                     Ada.Text_IO.put ('S');
                  elsif count = 5 then
                     Ada.Text_IO.put ('D');
                  end if;
                     count := 0;
                  end if;
               end loop;
         end loop;
         Ada.Text_IO.put_line ("");
      end;
   end loop;
end Main;
