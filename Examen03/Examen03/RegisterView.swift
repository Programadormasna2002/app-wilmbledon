
import SwiftUI

struct RegisterView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var confirmarPassword = ""
    @State private var mostrarPassword = false
    @State private var mostrarConfirmacion = false
    @State private var aceptarTerminos = false
    @State private var mostrarLogin = false
    @State private var mostrarAviso = false

    private let verde = Color(red: 0, green: 0.39, blue: 0.23)
    private let fondo = Color(red: 0.96, green: 0.96, blue: 0.98)

    var body: some View {
        VStack(spacing: 0) {

            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 23))
                        .foregroundStyle(.black)
                }

                Text("Sign up")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.black)

                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 32)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    campo("Email", texto: $email)

                    campoPassword(
                        "Password",
                        texto: $password,
                        visible: $mostrarPassword
                    )

                    campoPassword(
                        "Confirm password",
                        texto: $confirmarPassword,
                        visible: $mostrarConfirmacion
                    )

                    Toggle(isOn: $aceptarTerminos) {
                        (
                            Text("I have read, understand and agree to the ")
                                .foregroundColor(.gray)
                            + Text("Terms of Use")
                                .foregroundColor(verde)
                                .underline()
                        )
                        .font(.system(size: 16))
                    }
                    .toggleStyle(.checkboxWimbledon)
                    .padding(.top, 4)

                    (
                        Text("We process the data you provide, including in this form, to manage your myWimbledon account, including sending you agreed marketing. You can find more details about how we use your data and your data rights in our ")
                            .foregroundColor(.gray)
                        + Text("Privacy Policy.")
                            .foregroundColor(verde)
                            .underline()
                    )
                    .font(.system(size: 16))
                    .lineSpacing(6)
                }
                .padding(.top, 4)
            }
            .scrollDismissesKeyboard(.interactively)

            VStack(spacing: 12) {
                SocialButtonsView()

                Button {
                    mostrarAviso = true
                } label: {
                    Text("Sign up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(verde)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Button {
                    mostrarLogin = true
                } label: {
                    Text("Already have an account? Log in")
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
        .navigationDestination(isPresented: $mostrarLogin) {
            LoginView()
        }
        .alert("Registro", isPresented: $mostrarAviso) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text("El diseño está listo. Falta implementar el registro de usuarios.")
        }
    }

    private func campo(
        _ titulo: String,
        texto: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.system(size: 17, weight: .semibold))

            TextField("", text: texto)
                .keyboardType(.emailAddress)
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
    }

    private func campoPassword(
        _ titulo: String,
        texto: Binding<String>,
        visible: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.system(size: 17, weight: .semibold))

            HStack {
                Group {
                    if visible.wrappedValue {
                        TextField("", text: texto)
                    } else {
                        SecureField("", text: texto)
                    }
                }

                Button {
                    visible.wrappedValue.toggle()
                } label: {
                    Image(systemName: visible.wrappedValue
                          ? "eye.slash" : "eye")
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
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}

