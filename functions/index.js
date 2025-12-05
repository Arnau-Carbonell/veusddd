// functions/index.js
const functions = require("firebase-functions");
const express = require("express");
const { Resend } = require("resend"); // SDK oficial de Resend
const cors = require("cors");

// Nota: al usar secrets, declaramos runWith para montar el secreto en runtime
exports.sendContact = functions
    .runWith({ secrets: ["RESEND_API_KEY"] }) // montar secret en process.env
    .https.onRequest((req, res) => {
        const app = express();
        app.use(cors({ origin: true })); // permitir desde cualquier origen; ajustar en prod
        app.use(express.json());

        app.post("/", async (req, res2) => {
            try {
                // Validación básica (añade lo que necesites)
                const { name, email, message } = req.body || {};
                if (!name || !email || !message) {
                    return res2.status(400).json({ ok: false, error: "Campos incompletos" });
                }

                // Accede a la clave montada en runtime
                const apiKey = process.env.RESEND_API_KEY;
                if (!apiKey) {
                    console.error("RESEND_API_KEY no disponible");
                    return res2.status(500).json({ ok: false, error: "Server misconfigured" });
                }

                const resend = new Resend(apiKey);

                // Enviar email (HTML o text). Personaliza el from/subject/body.
                await resend.emails.send({
                    from: "no-reply@tu-dominio.com", // usa dominio verificado en Resend
                    to: "distribucio@veusdd.es",
                    subject: `Contacto web - ${name}`,
                    html: `
            <p><strong>Nombre:</strong> ${name}</p>
            <p><strong>Email:</strong> ${email}</p>
            <p><strong>Mensaje:</strong></p>
            <p>${message.replace(/\n/g, "<br>")}</p>
          `,
                });

                // (Opcional) guarda en Firestore si quieres
                // const admin = require("firebase-admin");
                // if (!admin.apps.length) admin.initializeApp();
                // await admin.firestore().collection('leads').add({ name, email, message, createdAt: Date.now() });

                return res2.json({ ok: true });
            } catch (err) {
                console.error("Error enviando email:", err);
                return res2.status(500).json({ ok: false, error: "error_sending" });
            }
        });

        // Express handler
        app(req, res);
    });
