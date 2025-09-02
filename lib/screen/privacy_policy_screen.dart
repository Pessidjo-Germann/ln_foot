import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de Confidentialité'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Politique de Confidentialité de LNfoot',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Notre web média de sport s’engage à protéger la confidentialité et la sécurité des données personnelles de nos utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons vos données personnelles.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Données Collectées',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Informations d’inscription (nom, prénom, adresse e-mail, mot de passe)\n- Informations de navigation (adresse IP, type de navigateur, pages visitées)\n- Informations de connexion (cookies, identifiants de session)',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Utilisation des Données',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Fournir des contenus et des services personnalisés\n- Améliorer notre site web et nos services\n- Vous envoyer des newsletters et des informations sur nos contenus et services\n- Répondre à vos questions et demandes',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Partage de Données',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Nos partenaires et annonceurs pour des publicités ciblées\n- Nos prestataires de services pour le traitement des données\n- Les autorités compétentes en cas de demande légale',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Sécurité des Données',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Chiffrement des données\n- Utilisation de protocoles de sécurité pour les transactions en ligne\n- Mise à jour régulière de nos systèmes et logiciels',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Vos Droits',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Accéder à vos données personnelles\n- Rectifier vos données personnelles\n- Supprimer vos données personnelles\n- Limiter le traitement de vos données personnelles',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Contact',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Si vous avez des questions ou des préoccupations concernant notre politique de confidentialité, veuillez nous contacter à luvnationagency2@gmail.com',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Modification de la Politique',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Nous pouvons modifier cette politique de confidentialité à tout moment. Nous vous informerons de tout changement important.',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Consentement',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'En utilisant notre site web, vous consentez à notre politique de confidentialité.',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Extension de la Politique',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                "Cette politique de confidentialité s’applique également à notre boutique en ligne, y compris toutes les interactions d’achat, de livraison et de paiement effectuées sur notre plateforme.",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Données liées aux transactions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Informations de paiement (mode de paiement, détails partiels de la carte)\n- Adresse de livraison et de facturation\n- Historique des commandes',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Utilisation des données (e-commerce)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                '- Traiter vos commandes et paiements\n- Assurer la livraison et le suivi des commandes\n- Gérer le service client après-vente',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Cookies marketing',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Nous utilisons des cookies pour suivre le comportement d’achat et vous proposer des offres personnalisées.',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Sécurité des paiements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Les transactions de paiement sont sécurisées via des prestataires certifiés (ex : SSL, prestataires de paiement reconnus).',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Lien vers les CGV/CGU',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text(
                'Cette politique est complémentaire à nos Conditions Générales de Vente ou d’Utilisation disponibles sur notre site.',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
