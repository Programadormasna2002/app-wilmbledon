
import SwiftUI

struct ContentView: View {

    @State private var mostrarLogo = false
    @State private var mostrarFondo = false
    @State private var mostrarWelcome = false

    var body: some View {

        ZStack {

            if mostrarWelcome {

                WelcomeView()

            } else if mostrarFondo {

                GeometryReader { geometry in
                    Image("WimbledonFondo")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                        .clipped()
                }
                .ignoresSafeArea()

            } else {

                ZStack {
                    Color.white
                        .ignoresSafeArea()

                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .scaleEffect(
                            mostrarLogo ? 1 : 0.5
                        )
                        .opacity(
                            mostrarLogo ? 1 : 0
                        )
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {

            withAnimation(.easeOut(duration: 1)) {
                mostrarLogo = true
            }

            // A los 2 segundos: fondo verde
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2
            ) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    mostrarFondo = true
                }
            }

            // A los 4 segundos: bienvenida
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 4
            ) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    mostrarWelcome = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
