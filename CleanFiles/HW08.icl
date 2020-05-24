module HW10
import StdEnv


/*
Given an array of Int and a single Int, use array
comprehension to double each element of the array,
keeping only the multiples of the second Int argument.
*/
//f1 :: {Int} Int -> {Int}
//Start = f1 {1,2,3,4} 4 //{4,8}
//Start = f1 {3,4,5,7,2,9} 3 //{6,18}

/*Task 1*/
f1 :: {Int} Int -> {Int}
f1 x a = {element*2\\element<-:x | ((element*2) rem a ) == 0 }

//|# Start = f1 {1,2,3,4} 4 //{4,8}
//|# Start = f1 {3,4,5,7,2,9} 3 //{6,18}



/*Task 2 */


// Given these Algebraic Data Types, Records, and Tree...
:: Gender = Male | Female | NonBinary | AttackHelicopter | Nghia | OOBLECK
:: LivingStatus = Alive | Deceased | Undead
:: MarriageStatus = Married | Divorced | Single | Tinder
:: Person = { name :: String, gender :: Gender, age :: Int, livingStatus :: LivingStatus, marriageStatus :: MarriageStatus}
:: FamilyTree a = Name a (FamilyTree a) (FamilyTree a) | End | Polygamy [[[[[[[[[[[[[FamilyTree a]]]]]]]]]]]]]

 //And these people:
Olivia = {name = "Olivia", gender = Female, age = 19, livingStatus = Alive, marriageStatus = Single}
Amelia = {name = "Amelia", gender = Female, age = 83, livingStatus = Alive, marriageStatus = Married}
Isla = {name = "Isla", gender = Female, age = 40, livingStatus = Alive, marriageStatus = Married}
Emily = {name = "Emily", gender = Female, age = 73, livingStatus = Alive, marriageStatus = Divorced}
Ava = {name = "Ava", gender = Female, age = 18, livingStatus = Alive, marriageStatus = Single}
Lily = {name = "Lily", gender = Female, age = 50, livingStatus = Alive, marriageStatus = Divorced}
Oliver = {name = "Oliver", gender = Male, age = 56, livingStatus = Alive, marriageStatus = Married}
Harry = {name = "Harry", gender = Male, age = 45, livingStatus = Alive, marriageStatus = Married}
Jack = {name = "Jack", gender = Male, age = 90, livingStatus = Deceased, marriageStatus = Married}
George = {name = "George", gender = Male, age = 43, livingStatus = Alive, marriageStatus = Married}
Noah = {name = "Noah", gender = Male, age = 74, livingStatus = Undead, marriageStatus = Divorced}
Freddie = {name = "Freddie", gender = Male, age = 24, livingStatus = Alive, marriageStatus = Single}
Ethan = {name = "Ethan", gender = Male, age = 20, livingStatus = Alive, marriageStatus = Single}

// And each person's immediate parents:
OliviaTree = Name Olivia OliverTree HarryTree
OliverTree = Name Oliver End End
HarryTree = Name Harry AmeliaTree JackTree
AmeliaTree = Name Amelia End End
JackTree = Name Jack End End
EthanTree = Name Ethan GeorgeTree IslaTree
GeorgeTree = Name George AmeliaTree JackTree
IslaTree = Name Isla NoahTree EmilyTree
NoahTree = Name Noah End End
EmilyTree = Name Emily End End
AvaTree = Name Ava LilyTree OliverTree
LilyTree = Name Lily End End
FreddieTree = Name Freddie End End

personsList = [Olivia, Amelia, Isla, Emily, Ava, Lily, Oliver, Harry, Jack, George, Noah, Freddie, Ethan]
familyList = [OliviaTree, OliverTree, HarryTree, AmeliaTree, JackTree, EthanTree, GeorgeTree, IslaTree, NoahTree, EmilyTree, AvaTree, LilyTree, FreddieTree]


/*
Write a function that tests if two persons are cousins
Condition: They share a grandparent.
*/
// areCousins :: Person Person -> Bool


ExtractPerson :: (FamilyTree a) -> a 
ExtractPerson (Name x l r) = x

// Start = ExtractPerson OliverTree //(Person "Oliver" Male 56 Alive Married)

takePersonTree:: Person [(FamilyTree Person)] -> (FamilyTree Person)
takePersonTree someone [x:xs] 
| someone == (ExtractPerson x) = x
= takePersonTree someone xs

getDaddy :: (FamilyTree Person) -> (FamilyTree Person)
getDaddy (Name x l r) = r

// Start = getDaddy OliviaTree //(Name (Person "Harry" Male 45 Alive Married) (Name (Person "Amelia" Female 83 Alive Married) End End) (Name (Person "Jack" Male 90 Deceased Married) End End))
// Start = getDaddy OliverTree//  End

TreetoList :: (FamilyTree Person) -> [Person]
TreetoList End =[]
TreetoList (Name x l r) = [x] ++ TreetoList l ++ TreetoList r 

// Start = TreetoList OliverTree //[(Person "Oliver" Male 56 Alive Married)]

Isit :: [Person] [Person] -> Bool
Isit x y
| ExtractPerson (getDaddy (getit(hd x)familyList)) == ExtractPerson (getDaddy (getit (hd y)familyList))= False
= or [a==b\\a<-tl x,b<- tl y] 

getit :: Person [FamilyTree Person] -> (FamilyTree Person)
getit x y = hd [a\\a<-y | x == ExtractPerson a]


//Was going for a different method. 
// instance == Gender
// where
// 	(==) Male Male = True
// 	(==) Male _ = False
// 	(==) _ Male = False
// 	(==) Female Female = True
// 	(==) Female _ = False
// 	(==) _ Female = False

// Start = Olivia.gender == Emily.gender //True

instance == Person
where
	(==) {name =n1} {name=n2} = n1==n2


// Start = Ethan == Olivia // False
// Start = Olivia == Olivia // True



areCousins :: Person Person -> Bool
areCousins x y = Isit (TreetoList (getit x familyList)) ((TreetoList(getit y familyList)))

// Start = areCousins Ethan Olivia //True
// Start = areCousins Ethan Ava //False
// Start = areCousins George Harry //False
// Start = areCousins George Isla //False
// Start = areCousins Ethan Ethan //False (same person)














/* Task 3 */

/*
Given a Tree of type Person, return the same tree, except
with "_qualify" attached to the end of the names of each person
who is over 18.
*/

// ::Person = { name::String
// 			,birthday::(Int,Int,Int)
// 	}
// ::Tree a = Node a (Tree a) (Tree a)
// 	|Leaf

// t1::Tree Person
// t1 = Node {name = "hh", birthday = (2001,11,22)} Leaf Leaf
// t2::Tree Person
// t2 = Node {name = "hh", birthday = (2005,11,22)} (Node {name = "hr", birthday = (2001,11,21)} Leaf Leaf)(Node {name = "ht", birthday = (2001,11,23)} Leaf Leaf)
// t3::Tree Person
// t3 = Node {name = "hh", birthday = (1999,11,22)} (Node {name = "hr", birthday = (2001,11,21)} (Node {name = "hh", birthday = (2003,11,22)} Leaf Leaf) (Node {name = "hh", birthday = (1998,11,22)} Leaf Leaf))(Node {name = "ht", birthday = (2005,11,23)} Leaf Leaf)


//Start = f3 t2 //(Node (Person "hh" (2005,11,22)) (Node (Person "hr_qualify" (2001,11,21)) Leaf Leaf) (Node (Person "ht_qualify" (2001,11,23)) Leaf Leaf))
//Start = f3 t3  //(Node (Person "hh_qualify" (1999,11,22)) (Node (Person "hr_qualify" (2001,11,21)) (Node (Person "hh" (2003,11,22)) Leaf Leaf) (Node (Person "hh_qualify" (1998,11,22)) Leaf Leaf)) (Node (Person "ht" (2005,11,23)) Leaf Leaf))



// f3 :: (Tree Person) -> (Tree Person)
// f3 Leaf = Leaf
// f3 (Node {name ,birthday= (y,m,d)} l r )
// | (2020 - y ) > 18 = (Node {name = name +++ "_qualify",birthday =(y,m,d)} (f3 l) (f3 r) )
// | otherwise = (Node {name=name , birthday= (y,m,d)} (f3 l) (f3 r))

// Start = f3 t2 //(Node (Person "hh" (2005,11,22)) (Node (Person "hr_qualify" (2001,11,21)) Leaf Leaf) (Node (Person "ht_qualify" (2001,11,23)) Leaf Leaf))
// Start = f3 t3  //(Node (Person "hh_qualify" (1999,11,22)) (Node (Person "hr_qualify" (2001,11,21)) (Node (Person "hh" (2003,11,22)) Leaf Leaf) (Node (Person "hh_qualify" (1998,11,22)) Leaf Leaf)) (Node (Person "ht" (2005,11,23)) Leaf Leaf))
