--  Author: Qi Mo, qmo2015@my.fit.edu
--  Author: Shiru Hou, shou2015@my.fit.edu
--  Course: CSE 4250, Fall 2017
--  Project: Proj3, Egyptian Hieroglyphs
--  Language Implementation: GNAT 20170515-63
package body  flood_fill is
  --  function that returns the number of enclosed white areas in one hieroglyph
   function count_enclosure (enclosure, H, W, I, J : in out Integer; 
                            myImage : in out image) return Integer is
   --  procedure that flips all connected black pixels to 'G'   
      procedure black_fill (H, W, I, J : Integer; myImage : in out image) is
      begin
      --  Once encounter a '0', 
      --  increments variable enclosure and 
      --  calls white_fill to flip all connected '0' to 'G'
         if myImage (I, J) = '0' then                                               
            enclosure := enclosure + 1;
            if I > 0 and J > 0 and I < (H - 1) and J < (W - 1) then 
               white_fill (myImage, H, W, I, J);
            end if;
            --  Otherwise, flips the pixel to 'G'
         elsif myImage (I, J) /= '0' and myImage (I, J) /= 'G'then                   
            myImage (I, J) := 'G';
            black_fill (H, W, I + 1, J, myImage);
            black_fill (H, W, I - 1, J, myImage);
            black_fill (H, W, I, J + 1, myImage);
            black_fill (H, W, I, J - 1, myImage);
         end if;   
      end black_fill;
   begin
      black_fill (H, W, I, J, myImage);
      return enclosure;
   end count_enclosure;

   --  flood_fill procedure that flips all connected '0' to 'G'  
   procedure white_fill (myImage :in out image; H, W, I, J : Integer) is        
   begin
      if myImage (I, J) = '0'  then
         myImage (I, J) := 'G';
         if I > 0 and J > 0 and I < (H - 1) and J < (W - 1) then
            white_fill (myImage, H, W, I + 1, J);
            white_fill (myImage, H, W, I - 1, J);
            white_fill (myImage, H, W, I, J + 1);
            white_fill (myImage, H, W, I, J - 1);
         end if;
      end if;
   end white_fill;
end flood_fill;
