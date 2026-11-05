
import SwiftUI

struct LoginView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var mostrarPassword = false
    @State private var usarFaceID = false
    @State private var mostrarRegistro = false
    @State private var mostrarRecuperacion = false
    @State private var mostrarAviso = false

    private let verde = Color(red: 0, green: 0.39, blue: 0.23)
    private let fondo = Color(red: 0.96, green: 0.96, blue: 0.98)

    var body: some View {
        VStack(spacing: 0) {

            // CABECERA
            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 23))
                        .foregroundStyle(.black)
                }

                Text("Log in")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.black)

                Spacer()

                Button("Skip") {
                    dismiss()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(verde)
            }
            .padding(.top, 20)
            .padding(.bottom, 32)

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 17, weight: .semibold))

                        TextField("", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .frame(height: 54)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.25))
                            }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 17, weight: .semibold))

                        HStack {
                            Group {
                                if mostrarPassword {
                                    TextField("", text: $password)
                                } else {
                                    SecureField("", text: $password)
                                }
                            }
                            .textContentType(.password)

                            Button {
                                mostrarPassword.toggle()
                            } label: {
                                Image(systemName: mostrarPassword ? "eye.slash" : "eye")
                                    .font(.system(size: 21))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding()
                        .frame(height: 54)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray.opacity(0.25))
                        }

                        Button("Forgot password?") {
                            mostrarRecuperacion = true
                        }
                        .font(.system(size: 15, weight: .medium))
                        .underline()
                        .foregroundStyle(verde)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top, 4)
                    }

                    Toggle(isOn: $usarFaceID) {
                        Text("Enable FaceID / TouchID")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                    }
                    .toggleStyle(.checkboxWimbledon)
                }
                .padding(.top, 4)
            }
            .scrollDismissesKeyboard(.interactively)

            // BOTONES INFERIORES
            VStack(spacing: 12) {

                SocialButtonsView()

                Button {
                    mostrarAviso = true
                } label: {
                    Text("Log in")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(verde)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Button {
                    mostrarRegistro = true
                } label: {
                    Text("Don't have an account? Sign up")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(verde)
                        .frame(height: 55)
                }
            }
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .background(fondo.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $mostrarRegistro) {
            RegisterView()
        }
        .alert("Recuperar contraseña", isPresented: $mostrarRecuperacion) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text("Próximamente podrás recuperar tu contraseña.")
        }
        .alert("Inicio de sesión", isPresented: $mostrarAviso) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text("El diseño está listo. Falta conectar la autenticación.")
        }
    }
}

// CHECKBOX PERSONALIZADO
struct WimbledonCheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: configuration.isOn
                      ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
                    .foregroundStyle(configuration.isOn ? .green : .gray)

                configuration.label
                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

extension ToggleStyle where Self == WimbledonCheckboxStyle {
    static var checkboxWimbledon: WimbledonCheckboxStyle {
        WimbledonCheckboxStyle()
    }
}

// BOTONES SOCIALES COMPARTIDOS
struct SocialButtonsView: View {
    var body: some View {
        HStack(spacing: 10) {
            socialButton("f.circle.fill", color: .blue)
            socialButton("g.circle.fill", color: .red)
            socialButton("apple.logo", color: .black)
        }
    }

    private func socialButton(_ icono: String, color: Color) -> some View {
        Button {
            // Pendiente integrar autenticación social
        } label: {
            Image(systemName: icono)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color(red: 0.90, green: 0.92, blue: 0.96))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}


