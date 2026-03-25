
func swap<T>( a : inout T ,  b : inout T ){
    (a,b) = (b,a)
}
func swapcall(){
    var a = 12 ,b = 30
    print("a", a, "b", b)
    //swap(&a,&b)
    swap(&a,&b)
    print("a", a, "b", b)
}
func callMe(index : Int){

    if index <= 0 {
        return
    }
   print("Rishabh")
    callMe(index: index - 1)
}

//callMe(index: 5) function calling

func loops (){
    //classic for loop
    print("Classic Loops")
    for i in 0...10 {
        print(i)
    }
    let numbers = [1,2,3,4,5,6,7]
    // advance for loop
    print("Advance Loops")
    for num in numbers {
        print(num)
    }

     
}
// loops() call on plaground
