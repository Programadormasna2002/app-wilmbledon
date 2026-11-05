
import SwiftUI

struct HomeView: View {

    @State private var seccion = 0
    @State private var pestana = 0

    private let verde = Color(
        red: 0.0,
        green: 0.39,
        blue: 0.23
    )

    private let fondo = Color(
        red: 0.96,
        green: 0.96,
        blue: 0.98
    )

    var body: some View {
        VStack(spacing: 0) {

            // CONTENIDO PRINCIPAL
            if seccion == 0 {
                inicio
            } else {
                Spacer()

                Text([
                    "Home",
                    "Scores",
                    "Draw",
                    "Schedule",
                    "More"
                ][seccion])
                .font(.largeTitle.bold())

                Spacer()
            }

            // MENÚ INFERIOR
            menuInferior
        }
        .background(fondo.ignoresSafeArea())
    }

    private var inicio: some View {
        VStack(spacing: 0) {

            // CABECERA
            HStack(spacing: 12) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)

                Text("28 June – 11 July 2027")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)

                Spacer()

                Text("IBM")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 18)
            .frame(height: 105)

            // PESTAÑAS
            HStack(spacing: 0) {
                botonPestana("Latest", indice: 0)
                botonPestana("Following", indice: 1)
                botonPestana("LIVE Video", indice: 2)
            }
            .frame(height: 55)

            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)

            ScrollView {
                VStack(spacing: 0) {

                    // HISTORIAS
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            historia(
                                "CHAMPION",
                                titulo: "Sinner is crowned 🏆",
                                color: .red
                            )

                            historia(
                                "CHAMPION",
                                titulo: "Noskova's victory 😍",
                                color: .red
                            )

                            historia(
                                "PLAY",
                                titulo: "Play of the Day",
                                color: verde
                            )

                            historia(
                                "DAY 13",
                                titulo: "Celeb watch",
                                color: verde
                            )
                        }
                        .padding(.horizontal, 18)
                    }
                    .padding(.vertical, 35)

                    // FEATURED
                    VStack(spacing: 28) {

                        Image(systemName: "sparkle")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 25))

                        Text("FEATURED")
                            .font(.system(
                                size: 34,
                                weight: .heavy
                            ))
                            .foregroundStyle(.white)

                        Image(systemName: "sparkle")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 25))

                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {
                            HStack(spacing: 15) {
                                tarjetaFeatured(
                                    "GRAND SLAM",
                                    subtitulo: "Shaping the Future Together"
                                )

                                tarjetaFeatured(
                                    "WIMBLEDON",
                                    subtitulo: "Latest tournament news"
                                )
                            }
                            .padding(.horizontal, 18)
                        }
                    }
                    .padding(.top, 55)
                    .padding(.bottom, 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color(
                            red: 0.02,
                            green: 0.17,
                            blue: 0.09
                        )
                    )
                }
            }
        }
    }

    private func botonPestana(
        _ titulo: String,
        indice: Int
    ) -> some View {
        Button {
            pestana = indice
        } label: {
            VStack(spacing: 10) {
                Text(titulo)
                    .font(.system(
                        size: 16,
                        weight: pestana == indice
                            ? .semibold : .regular
                    ))
                    .foregroundStyle(
                        pestana == indice ? verde : .gray
                    )
                    .lineLimit(1)

                Rectangle()
                    .fill(
                        pestana == indice
                            ? verde : .clear
                    )
                    .frame(height: 3)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func historia(
        _ texto: String,
        titulo: String,
        color: Color
    ) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(color, lineWidth: 3)
                    .frame(width: 90, height: 90)

                Circle()
                    .fill(verde)
                    .frame(width: 80, height: 80)

                Text(texto)
                    .font(.system(
                        size: 12,
                        weight: .bold
                    ))
                    .foregroundStyle(.white)
            }

            Text(titulo)
                .font(.system(
                    size: 12,
                    weight: .semibold
                ))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .frame(width: 100, height: 38)
        }
    }

    private func tarjetaFeatured(
        _ titulo: String,
        subtitulo: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(titulo)
                .font(.system(
                    size: 32,
                    weight: .black
                ))
                .foregroundStyle(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.6)

            Text(subtitulo)
                .font(.system(size: 17))
                .foregroundStyle(.black)
        }
        .padding(20)
        .frame(width: 300, height: 230)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }

    private var menuInferior: some View {
        HStack(spacing: 0) {
            itemMenu("Home", icono: "house.fill", indice: 0)
            itemMenu("Scores", icono: "sportscourt", indice: 1)
            itemMenu("Draw", icono: "square.grid.2x2", indice: 2)
            itemMenu("Schedule", icono: "calendar", indice: 3)
            itemMenu("More", icono: "ellipsis", indice: 4)
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(.white)
    }

    private func itemMenu(
        _ titulo: String,
        icono: String,
        indice: Int
    ) -> some View {
        Button {
            seccion = indice
        } label: {
            VStack(spacing: 7) {
                Image(systemName: icono)
                    .font(.system(size: 23))

                Text(titulo)
                    .font(.system(size: 12))
            }
            .foregroundStyle(
                seccion == indice ? .purple : .gray
            )
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeView()
}

