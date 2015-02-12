<%@ Page Language="C#" %>
<!DOCTYPE html>

<script runat="server">
    protected void uxSubmit_Click(object sender, EventArgs e)
    {
        uxSubmit.Visible = false;
        //set to null for delegate to be called in recursive anonymous function it must be assigned
        Func<int, int> fib = null;
        //closure captures delegate fib for use inside anonymous method implemented 
        //as lambda expression for the Fibonacci sequence calculations where each item is the sum of the previous 2 items
        fib = (n) => n > 1 ? fib(n - 1) + fib(n - 2) : n;
        //create list to store odd fib values
        List<int> fibOddNums = new List<int>();
        //call the fib 20 times
        for (int i = 0; i < 20; i++)
        {
            //dividing the fib by 2 checks to see if it is odd or even
            long odd = fib(i) / 2;
            // fib must be greater than 2, less than 1000 and odd
            if (fib(i) > 2 && fib(i) < 1000 && odd != 0)
            {
                //add fib to list
                fibOddNums.Add(fib(i));
            }
        }
        //output the sum of ints in the list
        Response.Write(fibOddNums.Sum());
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <ektronUI:Button ID="uxSubmit" runat="server" OnClick="uxSubmit_Click" Text="Sum of odd Fibonacci numbers 2 through 1000"></ektronUI:Button>
       </div>
    </form>
</body>
</html>
