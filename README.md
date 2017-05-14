# Postulación NNODES - Simulación de ruleta

[![N|Solid](https://scontent.fsst1-1.fna.fbcdn.net/v/t1.0-9/18520009_290517828038103_7385027949880136848_n.jpg?oh=c7447bf7c361d6ded59ae458299aba6b&oe=59AE6423)](#)

Aplicación para simular a un grupo de personas jugando a la ruleta, dependiendo del clima, los jugadores modifican sus apuestas.

Disponible en producción a través Heroku => [DEMO](https://roulette-app-nnodes.herokuapp.com/)

 ## Instalación local

1. Una vez situados en el directorio del proyecto, ejecutar el comando

    ```sh
    $ bundle install
    ```
2. Con esto tendremos las dependencias instaladas, ahora debemos revisar el archivo database.yml y comprobar que las credenciales estén correctas con tu base de datos local (PostgreSQL).
3. Crear la base y correr las migraciones correspondientes
    ```sh
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    ```

4. Registramos las tareas que se encuentran en **config/schedule.rb** en el crontab
    ```sh
    $ whenever --update-crontab
    ```
    Esto nos agregará 2 tareas
    - Cada 3 minutos se jugará una nueva partida
    - Al final del día cada jugador recibirá 10.000
    

5. Ejecutar la aplicación e ingresar a *localhost:3000* para ver el listado de partidas jugadas.
### Principales gemas utilizadas
| Gema | Sitio |
| ------ | ------ |
| rest-client | https://github.com/rest-client/rest-client |
| crack | https://github.com/jnunemaker/crack |
| pickup | https://github.com/fl00r/pickup|
| whenever | https://github.com/javan/whenever |

### Otras consideraciones

- Se utilizó la api del clima de [myweather2](http://www.myweather2.com/developer/) la cual entrega de manera gratuita el clima de los próximos 7 días.
- Como la aplicación está alojada en _Heroku_, no fue posible modificar el crontab, por lo que se crearon las mismas 2 tareas de **config/schedule.rb** en **lib/tasks/scheduler.rake** y se utilizó un add-on llamado [heroku-scheduler](https://devcenter.heroku.com/articles/scheduler) que permite tener la misma funcionalidad que whenever, solo que el tiempo mínimo de ejecución es de 10 minutos, en este caso, para el inicio de una nueva ronda.