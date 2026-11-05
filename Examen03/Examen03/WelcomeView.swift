
import SwiftUI

struct WelcomeView: View {

    @State private var cerrarWelcome = false
    @State private var mostrarLogin = false
    @State private var mostrarRegistro = false

    private let verde = Color(
        red: 0.0,
        green: 0.39,
        blue: 0.23
    )

    var body: some View {
        GeometryReader { geometry in

            if cerrarWelcome {

                // PANTALLA PRINCIPAL TEMPORAL
                ZStack {
                    Color.white
                        .ignoresSafeArea()

                    VStack(spacing: 15) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)

                        Text("Wimbledon")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.black)

                        Text("Pantalla principal")
                            .foregroundStyle(.gray)
                    }
                }

            } else {

                VStack(spacing: 0) {

                    // IMAGEN SUPERIOR
                    ZStack(alignment: .topTrailing) {

                        Color(
                            red: 0.0,
                            green: 0.30,
                            blue: 0.17
                        )

                        Image("WimbledonWelcome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height * 0.58,
                                alignment: .center
                            )

                        // BOTÓN X
                        Button {
                            cerrarWelcome = true
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(
                                    size: 20,
                                    weight: .medium
                                ))
                                .foregroundStyle(.white)
                                .frame(width: 46, height: 46)
                                .background(
                                    Color.black.opacity(0.8)
                                )
                                .clipShape(Circle())
                        }
                        .padding(.top, 55)
                        .padding(.trailing, 20)
                    }
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height * 0.58
                    )
                    .clipped()

                    // PARTE INFERIOR BLANCA
                    VStack(alignment: .leading, spacing: 14) {

                        Text("Unlock the full experience.")
                            .font(.system(
                                size: 24,
                                weight: .bold
                            ))
                            .foregroundStyle(.black)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )

                        Text("Get a personalised experience—follow players, receive live alerts, save favourites and unlock exclusive features.")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )

                        Spacer(minLength: 10)

                        // BOTÓN LOG IN
                        Button {
                            mostrarLogin = true
                        } label: {
                            Text("Log in")
                                .font(.system(
                                    size: 20,
                                    weight: .semibold
                                ))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(verde)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 12
                                    )
                                )
                        }

                        // BOTÓN SIGN UP
                        Button {
                            mostrarRegistro = true
                        } label: {
                            Text("Sign up")
                                .font(.system(
                                    size: 20,
                                    weight: .semibold
                                ))
                                .foregroundStyle(verde)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                        }

                        Spacer(minLength: 10)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 26)
                    .padding(.bottom, 30)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .background(Color.white)
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
        }
        .background(Color.white)
        .ignoresSafeArea()

        // ABRIR LOGIN
        .fullScreenCover(isPresented: $mostrarLogin) {
            NavigationStack {
                LoginView()
            }
        }

        // ABRIR REGISTRO
        .fullScreenCover(isPresented: $mostrarRegistro) {
            NavigationStack {
                RegisterView()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
