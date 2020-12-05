/*
  main.swift
  Minesweeper

  Created by Rafael Patino on 05/12/20.
  Copyright © 2020 Rafael Patino. All rights reserved.


Functions:
 
 - Empty: Creates a M*M boolean matrix initialized on false.
 
 - PonerMinas: It places random trues on a boolean matrix.
 
 - Probabilidad: It generates an Integer matrix with the number of bombs near each cell.
 
 - ShowFinal: It shows the solution of the game.
 
 - Show: Updates the board according to the already discovered cells.
 
 - DescubrirCampo: Takes the coordinates and updates the discovered-matrix.
 
 - ContarVisitados: It counts the number of cells that have been discovered. It helps to determine if you have won already.
 
*/


import Foundation

func Empty(M: Int) -> [[Bool]]
{
    var cuadricula: [[Bool]] = []
    
    for i in 0...M-1
    {
        cuadricula.append([])
        for _ in 0...M-1
        {
            cuadricula[i].append(false)
        }
    }
    return cuadricula
}

func PonerMinas(Num: Int, Cuadricula: [[Bool]])->[[Bool]]
{
    let size = Cuadricula.count
    var Minas = Cuadricula
    
    for _ in 1...Num
    {
        let random_fila = Int.random(in: 0..<size)
        let random_col = Int.random(in: 0..<size)
        
        Minas[random_fila][random_col] = true
    }
    
    return Minas
}

func Probabilidad(Cuadricula: [[Bool]]) -> [[Int]]
{
    let size = Cuadricula.count
    var numbers: [[Int]] = []
    
    for i in 0...size-1
    {
        numbers.append([])
        for _ in 0...size-1
        {
            numbers[i].append(0)
        }
    }
    
    for r in 0...size-1
    {
        for col in 0...size-1
        {
            // Si hay mina, poner 9
            if Cuadricula[r][col] == true
            {
                numbers[r][col] = 9
                continue
            }
            
            // Revisar arriba
            if (r>0) && (Cuadricula[r-1][col] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Revisar abajo
            if (r < size-1) && (Cuadricula[r+1][col] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Revisar Izquierda
            if (col > 0) && (Cuadricula[r][col-1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Revisar Derecha
            if (col < size-1) && (Cuadricula[r][col+1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Arriba Izquierda
            if (r > 0) && (col > 0) && (Cuadricula[r-1][col-1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Arriba Derecha
            if (r > 0) && (col < size-1) && (Cuadricula[r-1][col+1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Abajo Izquierda
            if (r < size-1) && (col > 0) && (Cuadricula[r+1][col-1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
            
            // Abajo Derecha
            if (r < size-1) && (col < size-1) && (Cuadricula[r+1][col+1] == true)
            {
                numbers[r][col] = numbers[r][col] + 1
            }
        }
    }
    return numbers
}

func ShowFinal(Cuadricula: [[Int]]) -> Void
{
    let size = Cuadricula.count
    
    var horizontal = "    "
    
    for _ in 0...size*3
    {
        horizontal.append("-")
    }
    horizontal.append("-")
    horizontal.append("-")
    horizontal.append("-")
    horizontal.append("-")
    
    let alfabeto = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    var letras = "        "
    for i in 0...size-1
    {
        letras.append(alfabeto[i] + "  ")
    }
    print(letras)
    
    print(horizontal)
    
    var line = ""
    for i in 0...size-1
    {
        if i<9
        {
            line = "   0" + String(i+1) + "|  "
        }
        else
        {
            line = "   " + String(i+1) + "|  "
        }
        
        for j in 0...size-1
        {
            line.append(String(Cuadricula[i][j]) + "  ")
        }
        print(line + "|")
    }
    
    print(horizontal)
}

func Show(Cuadricula: [[Int]], Descubiertos: [[Bool]]) -> Void
{
    let size = Cuadricula.count
    
    var horizontal = "    "
    
    for _ in 0...size*3
    {
        horizontal.append("-")
    }
    horizontal.append("-")
    horizontal.append("-")
    horizontal.append("-")
    horizontal.append("-")
    
    let alfabeto = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    var letras = "        "
    for i in 0...size-1
    {
        letras.append(alfabeto[i] + "  ")
    }
    print(letras)
    
    print(horizontal)
    
    var line = ""
    for i in 0...size-1
    {
        if i<9
        {
            line = "   0" + String(i+1) + "|  "
        }
        else
        {
            line = "   " + String(i+1) + "|  "
        }
        
        for j in 0...size-1
        {
            if(Descubiertos[i][j] == true)
            {
              line.append(String(Cuadricula[i][j]) + "  ")
            }
            else{line.append("*" + "  ")}
        }
        print(line + "|")
    }
    
    print(horizontal)
}

func DescubirCampo(Cuadricula: [[Int]], Descubiertos: inout [[Bool]], r: Int, col:Int)-> Void
{
  let size = Cuadricula.count

  if(Cuadricula[r][col] != 9)
  {
    if(Descubiertos[r][col] == false)
    {
      Descubiertos[r][col] = true
      if(Cuadricula[r][col] == 0)
      {
        if(r>0)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r-1, col:col)
        }
        if(r<size-1)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r+1, col:col)
        }
        if(col>0)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r, col:col-1)
        }
        if(col < size-1)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r, col:col+1)
        }
        if(r > 0 && col > 0)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r-1, col:col-1)
        }
        if(r < 0 && col < size-1)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r-1, col:col+1)
        }
        if (r < size-1 && col > 0)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r+1, col:col-1)
        }
        if (r < size-1 && col < size-1)
        {
          DescubirCampo(Cuadricula: Cuadricula, Descubiertos: &Descubiertos, r: r+1, col:col+1)
        }
      }
    }
  }
  else
  {
    Descubiertos = [[true]]
  }
}

func ContarVisitados(Descubiertos: [[Bool]])->Int
{
  let size = Descubiertos.count
  var count = 0

  for i in 0...size-1
  {
    for j in 0...size-1
    {
      if(Descubiertos[i][j] == true)
      {
        count = count+1
      }
    }
  }
  return count
}


// Main

print("-- Welcome to Minesweeeeeper --")
print("")
print("Chose a difficulty:")
print("")
print("     A. Noob")
print("     B. Normal")
print("     C. You are crazy")
print("")


var size = 0
var B = 0

var seguir = true

while (seguir)
{
  
print("Select an option: ")
let opc = readLine()!

  switch opc.uppercased()
  {
      case "A":
      size = 10
      B = 5
      seguir = false
      
      case "B":
      size = 18
      B = 40
      seguir = false

      case "C":
      size = 24
      B = 99
      seguir = false

      default:
      print("That option does not exist, try again")
      seguir = true
  }
}


let CampoLibre = Empty(M: size)
var MatrizDescubiertos = Empty(M: size)
let CampoMinado = PonerMinas(Num: B, Cuadricula: CampoLibre)
let MatrizProbabilidad = Probabilidad(Cuadricula: CampoMinado)

print("")
print("")

Show(Cuadricula: MatrizProbabilidad, Descubiertos: MatrizDescubiertos)

var fin = false
var coordenada = ""
var col = 0

//Game

while(!fin)
{
  print("Input the column: ")
  let letra = readLine()!

  print("Input the row: ")
  let fila = readLine()!

  switch letra.uppercased()
  {
  case "A":
  col = 0
  case "B":
  col = 1
  case "C":
  col = 2
  case "D":
  col = 3
  case "E":
  col = 4
  case "F":
  col = 5
  case "G":
  col = 6
  case "H":
  col = 7
  case "I":
  col = 8
  case "J":
  col = 9
  case "K":
  col = 10
  case "L":
  col = 11
  case "M":
  col = 12
  case "N":
  col = 13
  case "O":
  col = 15-1
  case "P":
  col = 16-1
  case "Q":
  col = 17-1
  case "R":
  col = 18-1
  case "S":
  col = 19-1
  case "T":
  col = 20-1
  case "U":
  col = 21-1
  case "V":
  col = 22-1
  case "W":
  col = 23-1
  case "X":
  col = 24-1
  case "Y":
  col = 25-1
  case "Z":
  col = 26-1
  default:
  col = 0
  }

  DescubirCampo(Cuadricula: MatrizProbabilidad, Descubiertos: &MatrizDescubiertos,r: Int(fila)!-1, col: col)

  if(MatrizDescubiertos.count < 2)
  {
    print("!!! ******************************* !!!")
    print("!!!       UPS THAT WAS A MINE       !!!")
    print("!!! ******************************* !!!")
    fin = true
  }
  else // Imprimir mapa
  {
    Show(Cuadricula: MatrizProbabilidad, Descubiertos: MatrizDescubiertos)
  }

  // Verificar que hayas ganado
  if(ContarVisitados(Descubiertos: MatrizDescubiertos) == size*size - B)
  {
    print("---------------------------------------")
    print("|!!         Congratulations         !!|")
    print("|!!             YOU WIN             !!|")
    print("---------------------------------------")
    fin = true
  }
}
