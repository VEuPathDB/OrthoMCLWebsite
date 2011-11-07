import java.text.DecimalFormat;
import java.text.NumberFormat;


public class Test {

    public static void main(String[] args) {
        double d = 0;
        NumberFormat formatter = new DecimalFormat("0.###E0");

        System.out.println(formatter.format(d));
    }
}
