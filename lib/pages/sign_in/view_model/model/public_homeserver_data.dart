// SPDX-FileCopyrightText: 2019-Present Christian Kußowski
// SPDX-FileCopyrightText: 2019-Present Contributors to FluffyChat
//
// SPDX-License-Identifier: AGPL-3.0-or-later

class PublicHomeserverData {
  final String? name;
  final String? clientDomain;
  final String? website;
  final String? isp;
  final String? staffJur;
  final String? rules;
  final String? privacy;
  final bool? usingVanillaReg;
  final String? description;
  final String? regMethod;
  final String? regLink;
  final String? software;
  final String? version;
  final bool? captcha;
  final bool? email;
  final List<String>? languages;
  final List<String>? features;
  final int? onlineStatus;
  final String? serverDomain;
  final int? verStatus;
  final int? roomDirectory;
  final bool? slidingSync;
  final bool? ipv6;

  PublicHomeserverData({
    this.name,
    this.clientDomain,
    this.website,
    this.isp,
    this.staffJur,
    this.rules,
    this.privacy,
    this.usingVanillaReg,
    this.description,
    this.regMethod,
    this.regLink,
    this.software,
    this.version,
    this.captcha,
    this.email,
    this.languages,
    this.features,
    this.onlineStatus,
    this.serverDomain,
    this.verStatus,
    this.roomDirectory,
    this.slidingSync,
    this.ipv6,
  });
}
