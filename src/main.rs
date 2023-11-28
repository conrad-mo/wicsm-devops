use axum::{
    routing::get,
    Router,
};
use tower_http::cors::{Any, CorsLayer};
use tokio::net::TcpListener;
#[tokio::main]
async fn main() {
    let cors = CorsLayer::new().allow_origin(Any);

    let app = Router::new()
        .route("/", get(root))
        .layer(cors);

    let listener = TcpListener::bind("0.0.0.0:3000").await.unwrap();
    println!("listening on {:?}", listener);
    axum::serve(listener, app).await.unwrap();
}

async fn root() -> &'static str {
    "Backend reached"
}
