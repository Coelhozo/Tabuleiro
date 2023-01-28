if (window.history.replaceState) {
    window.history.replaceState( null, null, window.location.href );
}

let position = 0;
let player = document.getElementsByTagName("base")[0]['attributes']['player']['textContent'];
let thisPlayer = document.getElementsByTagName("base")[0]['attributes']['thisPlayer']['textContent'];

if (thisPlayer == player){
    counter(5);
}else{
    document.getElementsByClassName('counter')[0].style.display = "none";
}

mostrarPosicoes();
avancar(document.getElementsByTagName("base")[0]['attributes']['avancar']['textContent']);

function mostrarPosicoes() {
    let players = ["player-1", "player-2", "player-3"];
    //let index = players.indexOf(player);
    //players.splice(index, 1);
    
    console.log(players);
    players.forEach(jogadores => {
        console.log(jogadores);
        let casas = document.getElementById(jogadores)['innerHTML'].split(" ");
        casas.forEach((elemento, index) => {
            if (elemento == "<div><span></span></div>") {
                casas[index] = "<div></div>";
            }
        });

        position = document.getElementsByTagName("base")[0]['attributes']['posicao-'+jogadores]['textContent'];
        console.log(position);

        casas[position-1] = "<div><span></span></div>";
        console.log(casas); 

        casas = casas.join(' ');
        console.log(casas);
        document.getElementById(jogadores)['innerHTML'] = casas;
    });
}

function avancar(player) {
    if (player=='') return;
    let casas = document.getElementById(player)['innerHTML'].split(" ");
    /*
    if (!posicao==''){
        casas[0] = "<div></div>";
        casas[posicao] = "<div><span></span></div>";
    }
    */
    casas.forEach((elemento, index) => {
        if (elemento == "<div><span></span></div>") {
            position = index;
        }
    });

    casas[position-1] = "<div></div>";

    
    if (position == 10){
        position = 0;
    }
    
    casas[position] = "<div><span></span></div>";
    casas = casas.join(' ');

    document.getElementById(player)['innerHTML'] = casas;
}

function mostrarPergunta(){
    if (!document.getElementsByClassName("modal")[0]["style"]["display"]){
        document.getElementsByClassName("modal")[0]["style"]["display"] = "flex";
    }else{
        document.getElementsByClassName("modal")[0]["style"]["display"] = "";
    }
}

function counter(contagem) {
    c=contagem;
    if (contagem < 10){
        timer = setInterval(() => {
            c--;
            if (c <= 0){
                document.getElementById('counter')['innerText'] = "começar!"
            }else{
                document.getElementById('counter')['innerText'] = c.toString();
            }
    
            if(c == -1){
                clearInterval(timer);
                document.getElementsByClassName('counter')[0]["style"]["display"] = "none";
                mostrarPergunta();
                counter(11);
            }
        }, 1000);

        return;
    }

    if (contagem < 20){
        timer = setInterval(() => {
            c--;
            document.getElementsByClassName('timer')[0]['innerText'] = "tempo restante: "+c.toString();

            if (c == -1){
                clearInterval(timer);
            }
        }, 1000);
    }
}