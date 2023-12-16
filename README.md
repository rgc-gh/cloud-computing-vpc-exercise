# cloud-computing-vpc-exercise

La empresa está investigando cómo proporcionar una arquitectura de red que permita centralizar la conectividad con internet para una aplicación específica que requiere pasar un compliance de seguridad muy estricto.

Por ello, quiere que montemos una VPC con IGW que contenga dos subredes públicas con un NATgw y que haga peering con otras VPCs que NO dispondrá de IGW y por lo tanto no podrá hablar directamente con internet, pero que reenviará las peticiones de salida (por ejemplo, para descargar parches) a la primera. En estas otras VPCs será donde se ejecuten, lógicamente, las cargas de trabajo.
