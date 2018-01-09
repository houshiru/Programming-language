--  Author: Qi Mo, qmo2015@my.fit.edu
--  Author: Shiru Hou, shou2015@my.fit.edu
--  Course: CSE 4250, Fall 2017
--  Project: Proj3, Egyptian Hieroglyphs
--  Language Implementation: GNAT 20170515-63
package flood_fill is
   type image is array (Integer range <>, Integer range <>) of Character;
   procedure white_fill (myImage : in out image; H, W, I, J : Integer);
   function count_enclosure (enclosure, H, W, I, J : in out Integer;
                            myImage : in out image) return Integer;
end flood_fill;
